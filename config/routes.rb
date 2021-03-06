Ganban::Application.routes.draw do
  resources :documents

  resources :profiles

  resources :checklists do
    put :done, on: :member
  end

  resources :comments

  resources :cards, except: [:new, :edit] do
    put :move, on: :member
  end

  resources :lists do
    put :move, on: :member
  end

  resources :current_projects, only: [:create]

  resources :projects do
    get :users, on: :member
    get :auto_users, on: :collection
  end

  resources :collaborators, only: [:index, :create, :destroy]

  devise_for :admins, controllers: {sessions: 'hq/sessions'}, path: 'hq',
             path_names: {sign_in: 'login', sign_out: 'logout', password: 'secret',
                          confirmation: 'verification'}
  devise_for :users,
             path: 'accounts',
             controllers: {registrations: 'registrations', sessions: 'sessions',},
             path_names: {sign_in: 'login', sign_up: 'new', sign_out: 'logout', password: 'secret',
                          confirmation: 'verification'}
  root to: 'welcome#index'
  namespace :hq do
      resources :dashboard, only: [:index]
  end

  resources :agent_sessions, only: :create

  resources :dashboard, only: [:index]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
