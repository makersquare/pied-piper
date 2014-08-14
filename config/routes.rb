Crm::Application.routes.draw do
  # ROOT ALWAYS AT TOP
  root 'static_pages#index'
  #if the google authentication results in a failure redirect to root
  get 'auth/failure', to: redirect('/')

  #this route is the redirect route that is triggered after sending an authentication request to google
  get 'auth/:provider/callback', to: 'sessions#create'

  #trigger session destruction on logout
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:show]

  #provides a root route to show login button, can be changed later

  # put 'pipeline/:pipeline_id/contact/:contact_id' => 'contacts#update'

  resources :pipelines do
    resources :stages, :defaults => { :format => :json }
    resources :contacts do
      resources :notes, :defaults => { :format => :json }
    end
    resources :boxes
    resources :users

    resources :fields, :defaults => { :format => :json }

    get 'users', to: 'pipelines#retrieve_collaborators'
    post 'users', to: 'pipelines#add_to_pipeline'
    delete 'users/:user_id', to: 'pipelines#remove_from_pipeline'
    put 'users/:user_id', to: 'pipelines#update_access_to_pipeline'
  end

  resources :contacts
  resources :boxes
  resources :users do
    resources :email_settings, :defaults => { :format => :json }
  end

  post 'contextio/webhook/' => 'contextio#callback'

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
