Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'items/find_all', to: 'items/search#index'
      get 'merchants/find', to: 'merchants/search#show'

        # get '/merchants/find', to: 'search#merchant'
        # get '/merchants/find_all', to: 'search#all_merchants'
        # get '/items/find_all', to: 'search#all_items'
        # get '/items/find', to: 'search#item'

      resources :merchants, only: [:index, :show] do
        get '/items', to: 'merchant_items#index'
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get '/merchant', to: 'item_merchant#show'
      end
    end
  end
end


