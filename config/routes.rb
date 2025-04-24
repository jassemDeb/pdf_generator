Rails.application.routes.draw do
  get "pdf_reports/generate"
  resources :reports
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Route for generating PDF
  get 'reports/:id/download_pdf', to: 'reports#download_pdf', as: 'download_report'

  # Defines the root path route ("/")
  root "reports#index"
end
