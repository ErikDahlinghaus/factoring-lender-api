# TODO: Test attachment upload in a blackbox way
# This code is an example that is kinda close

# require 'faraday'
#
# conn = Faraday.new(url: 'http://localhost:3000') do |faraday|
#   faraday.request :multipart
#   faraday.adapter :net_http
# end
#
# file = File.open('/path/to/file.pdf', 'rb')
# payload = {
#   invoice: {
#     invoice_scan: Faraday::UploadIO.new(file, 'application/pdf')
#   }
# }
#
# response = conn.post('/invoices/:id/invoice_scan', payload)