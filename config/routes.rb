Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pdm_logs#index" 

  get '/pdm-logs/download', to: 'pdm_logs#download'
  get '/pdm-logs/newcreate', to: 'pdm_logs#newcreate'
  get '/pdm-logs/versionup', to: 'pdm_logs#versionup'
  get '/pdm-logs/engchange', to: 'pdm_logs#engchange'
  
  resources :pdm_logs, path: 'pdm-logs'

end
