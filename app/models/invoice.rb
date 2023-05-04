require 'securerandom'
require 'aasm'

class Invoice < ApplicationRecord
  belongs_to :borrower
  has_one_attached :invoice_scan
  before_create :generate_invoice_number, :set_created_date
  validates :amount, :fee_percentage, :due_date, :borrower, presence: true

  # TODO: I have a bunch of date columns for saving the datetime of
  # the various state transitions.
  # I think its important to track these dates, but this seems
  # kind of clunky. Perhaps it might be better to implement an audit log.
  #
  # Excerpt of table create
  # t.date :created_date
  # t.date :approved_date
  # t.date :rejected_date
  # t.date :purchased_date
  # t.date :closed_date

  include AASM
  aasm column: :state, no_direct_assignment: true do
    state :created, initial: true
    state :approved
    state :rejected
    state :purchased
    state :closed

    event :approve, after: :set_approved_date do
      transitions from: :created, to: :approved
    end

    event :reject, after: :set_rejected_date do
      transitions from: :created, to: :rejected
    end

    event :purchase, after: :set_purchased_date do
      transitions from: :approved, to: :purchased
    end

    event :close, after: :set_closed_date do
      transitions from: :purchased, to: :closed
    end
  end

  def accrued_fees
    return 0 if self.created? || self.rejected? || self.approved?

    closed_or_current_date = self.closed_date if self.closed?
    closed_or_current_date ||= Date.current

    days_since_due = closed_or_current_date - self.due_date
    return 0 if days_since_due <= 2.0

    fee_to_accrue = self.amount * self.fee_percentage
    accrued_fees = fee_to_accrue * (days_since_due - 2.0)
  
    return accrued_fees.round(2)
  end

  private

  # TODO: This UUID is not necessarily going to be unique when generated.
  # This will lead to it generating a UUID which collides with an existing record
  # Because there is a unique constraint on the invoice_number, this would
  # cause record creation to fail. There would be no mechanism for the record to
  # be created again, must trigger this method again and then pray for no collision.
  # There are several ways to fix this but since its so unlikely to hit a collision
  # this potential bug can stay for now.
  def generate_invoice_number
    self.invoice_number ||= SecureRandom.uuid
  end

  def set_created_date
    self.created_date = Date.current
  end

  # TODO: According to AASM docs I shouldn't need to call
  # self.save! in these callbacks but if I don't
  # then it doesn't update the dates
  # It would be wise to figure this out because these have side effects
  # if other methods were to call them
  def set_approved_date
    self.approved_date = Date.current
    self.save!
  end

  def set_rejected_date
    self.rejected_date = Date.current
    self.save!
  end

  def set_purchased_date
    self.purchased_date = Date.current
    self.save!
  end

  def set_closed_date
    self.closed_date = Date.current
    self.save!
  end
end
