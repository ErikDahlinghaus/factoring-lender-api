class InvoiceSerializer < ActiveModel::Serializer
  attributes :self_url, :borrower_url, :invoice_number, :amount, :fee_percentage, :accrued_fees, :state, :created_date,
             :approved_date, :rejected_date, :purchased_date, :closed_date, :due_date, :invoice_scan_url

  # TODO: Use url_for or something for these URLs
  def self_url
    return "http://localhost:3000/invoices/#{object.id}"
  end

  def borrower_url
    return "http://localhost:3000/borrowers/#{object.borrower.id}"
  end

  def invoice_scan_url
    return object.invoice_scan.service_url if object.invoice_scan.attached?
    return ""
  end
end

