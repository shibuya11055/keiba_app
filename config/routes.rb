Rails.application.routes.draw do
  root to: 'home#index'
  get '/new',  to: 'home#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :home, only: [:index]
      # レース予想
      resources :expected_races, only: [:create] do
        collection do
          get :candidate_races
          get :candidate_horses
          get :candidate_jockeys
        end
      end
    end
  end
end
