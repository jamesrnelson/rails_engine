Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/revenue', to: 'revenue#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end
      resources :transactions, only: [:index, :show]

      namespace :invoices do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get '/:id/merchant', to: 'merchants#show'
        get '/:id/invoice_items', to: 'invoice_items#index'
      end

      namespace :invoice_items do
        get '/:id/invoice', to: 'invoices#show'
        get '/:id/item', to: 'items#show'
      end

      resources :customers, only: [:index]

    end
  end
end
