Crm::Application.routes.draw do
  # ROOT ALWAYS AT TOP
  root :to => 'static_pages#index'

  #if the google authentication results in a failure redirect to root
  get 'auth/failure', to: redirect('/login')
  get 'login', to: 'static_pages#login'

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

    resources :contacts, controller: 'pipeline_contacts' do
      resources :notes, :defaults => { :format => :json }
    end
    resources :boxes
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

  post '/payments/credit', to: 'payments#create', :defaults => { :format => :json }
  post '/payments/bank', to: 'payments#show'

  post 'contextio/webhook/' => 'contextio#callback'


end
