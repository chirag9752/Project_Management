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

    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'
    get '/users/details/:id', to: 'users#detailsshow'

    # timesheet
    post '/timesheets/fetchsingletimesheet', to: 'timesheets#fetch_single'

    # post '/projects', to: 'projects#create'
    get '/projects', to: 'projects#index'
    get '/projects/:id', to: 'projects#show'

    # features

    post 'users/execute_feature', to: 'hr/features#execute'
    post 'users/checkinguserfeature', to: 'hr/features#checking_user_feature'
    get 'users/features/index', to: 'hr/features#index'

    # profiles 
    get '/profiles', to: 'profiles#index' 
end
