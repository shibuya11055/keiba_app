Rails.application.routes.draw do
  root to: 'home#index'
  get '/expected_races', to: 'home#index'
  get '/expected_races/*path',  to: 'home#index'
  get '/horses',  to: 'home#index'
  get '/horses/*path',  to: 'home#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :home, only: [:index]
      # レース予想
      resources :expected_races, only: [:index, :create, :show] do
        collection do
          get :candidate_races
          get :candidate_horses
          get :candidate_jockeys
          get :candidate_traners
        end
      end

      resources :races, only: [:destroy]

      resources :horses, only: [:index, :create]
    end
  end
end
