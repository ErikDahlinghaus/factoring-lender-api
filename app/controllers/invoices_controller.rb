class InvoicesController < ApplicationController
  def index
    invoices = Invoice.all
    render json: invoices, each_serializer: InvoiceSerializer
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Invoices not found" }, status: :not_found
  end

  # TODO: Consider allowing the API consumer to specify invoice_number instead
  def show
    invoice = Invoice.find(params[:id])
    render json: invoice, serializer: InvoiceSerializer
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Invoice not found" }, status: :not_found
  end

  def create
      invoice = Invoice.new(invoice_params)
      if invoice.save
        render json: invoice, serializer: InvoiceSerializer, status: :created
      else
        render json: { error: "Record not created" }, status: :unprocessable_entity
      end
  end

  # TODO: There is probably lots of things that could go wrong here
  # But we don't currently have time to address this feature
  # Work with PM to evaluate importance of this feature and schedule it in a sprint
  # Pimarily requires integration testing
  def upload
    invoice = Invoice.find(params[:id])
    invoice.invoice_scan.attach(params[:invoice_scan])
    invoice.save!
  end

  def invoice_scan_show
    invoice = Invoice.find(params[:id])
    if invoice.invoice_scan.attached?
      send_data invoice.invoice_scan.download, filename: invoice.invoice_scan.filename.to_s, type: invoice.invoice_scan.content_type, disposition: 'inline'
    else
      render json: { error: "Invoice scan not found" }, status: :not_found
    end
  end

  private

  # TODO: Allow creating a record in another state than Created, allow to specify dates for state changes
  def invoice_params
    params.require(:invoice).permit(:borrower, :amount, :fee_percentage, :due_date, :invoice_file).tap do |invoice_params|
      raise ActionController::ParameterMissing.new("amount is required") if invoice_params[:amount].blank?
      raise ActionController::ParameterMissing.new("due_date is required") if invoice_params[:due_date].blank?
      raise ActionController::ParameterMissing.new("borrower is required") if invoice_params[:borrower].blank?
    end
  end
end
