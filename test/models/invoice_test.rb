require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  def setup
    @borrower1 = Borrower.create(name: "Landscape Business")
    @borrower2 = Borrower.create(name: "Donuts Business")
  end

  test "accrued_fees calculates the correct amount for 4 day overdue invoices" do
    invoice = Invoice.create(borrower: @borrower1, amount: 100, fee_percentage: 0.02, due_date: Date.current - 4.days)
    invoice.approve!
    invoice.purchase!

    assert_equal 4.0, invoice.accrued_fees
  end

  test "accrued_fees calculates the correct amount for 12 day overdue invoices" do
    invoice = Invoice.create(borrower: @borrower1, amount: 100, fee_percentage: 0.02, due_date: Date.current - 12.days)
    invoice.approve!
    invoice.purchase!

    assert_equal 20.0, invoice.accrued_fees
  end

  test "accrued_fees calculates the correct amount for a closed invoice, stopping accrual" do
    invoice = Invoice.create(borrower: @borrower1, amount: 100, fee_percentage: 0.02, due_date: Date.parse("2023-02-10"))
    invoice.approve!
    invoice.purchase!
    invoice.close!
    invoice.closed_date = Date.parse("2023-02-14")

    assert_equal 4.0, invoice.accrued_fees
  end

  test "accrued_fees is 0 when the invoice is state :created" do
    invoice = Invoice.create(borrower: @borrower1, amount: 100, fee_percentage: 0.02, due_date: Date.current - 4.days)

    assert_equal 0, invoice.accrued_fees
  end

  test "accrued_fees is 0 when the invoice is state :approved" do
    invoice = Invoice.create(borrower: @borrower1, amount: 100, fee_percentage: 0.02, due_date: Date.current - 4.days)
    invoice.approve!

    assert_equal 0, invoice.accrued_fees
  end

  test "accrued_fees is 0 when the invoice is state :rejected" do
    invoice = Invoice.create(borrower: @borrower1, amount: 100, fee_percentage: 0.02, due_date: Date.current - 4.days)
    invoice.reject!

    assert_equal 0, invoice.accrued_fees
  end
end