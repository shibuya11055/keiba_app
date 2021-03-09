Rails.application.routes.draw do
  root to: 'home#index'
  get '/*path',  to: 'home#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :home, only: [:index]
    end
  end
end
