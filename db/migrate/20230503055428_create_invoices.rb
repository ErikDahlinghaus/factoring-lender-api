class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :invoice_number, unique: true
      t.decimal :amount
      t.decimal :fee_percentage
      t.date :due_date
      t.date :created_date
      t.date :approved_date
      t.date :rejected_date
      t.date :purchased_date
      t.date :closed_date
      t.string :state
      t.references :borrower, null: false, foreign_key: true

      t.timestamps
    end
  end
end
