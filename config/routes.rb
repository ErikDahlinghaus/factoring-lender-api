Rails.application.routes.draw do
  # TODO: Add a root path route to ??? or just a 404
  # TODO: Consider using resources declaration rather than individual routes
  get '/borrowers', to: 'borrowers#index'
  get '/borrowers/:id', to: 'borrowers#show'

  get '/invoices', to: 'invoices#index'
  get '/invoices/:id', to: 'invoices#show'

  post '/invoices/:id/invoice_scan', to: 'invoices#upload'
  get '/invoices/:id/invoice_scan', to: 'invoices#invoice_scan_show'
end
