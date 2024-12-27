Rails.application.routes.draw do
   devise_for :users,
     path: '',    #root path
     path_names: {
       sign_in: 'login',
       sign_out: 'logout',
       registration: 'signup'
     },
     controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    },
    defaults: { format: :json } 

    # config/routes.rb
    # namespace :hr do
    #   resources :features, only: [] do
    #     post :assign_feature, on: :collection
    #     delete :remove_feature, on: :collection
    #   end
    # end

    # config/routes.rb

    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'

    # projects

    # post '/projects', to: 'projects#create'
    get '/projects', to: 'projects#index'
    get '/projects/:id', to: 'projects#show'

    # features

    post 'users/execute_feature', to: 'hr/features#execute'
    post 'users/checkinguserfeature', to: 'hr/features#checkinguserfeature'
    get 'users/features/index', to: 'hr/features#index'
    
end
