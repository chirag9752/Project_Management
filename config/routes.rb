Rails.application.routes.draw do
   devise_for :users,
     path: '',
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
    
    #user
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'
    get '/users/details/:id', to: 'users#detailsshow'
    post '/users/update/profile/:id', to: 'users#update'
    # get '/users/image/:id', to: 'users#fetch_single_user_image'

    # timesheet
    post '/timesheets/fetchsingletimesheet', to: 'timesheets#fetch_single_timesheet'
    post '/timesheets/fetchpdf', to: 'timesheets#fetch_custom_date_pdf'
    post '/timesheets/fetchcsv', to: 'timesheets#fetch_custom_date_csv'

    # post '/projects', to: 'projects#create'
    get '/projects', to: 'projects#index'
    get '/projects/:id', to: 'projects#show'

    # features
    post 'users/execute_feature', to: 'hr/features#execute'
    post 'users/checkinguserfeature', to: 'hr/features#checking_user_feature'
    get 'users/features/index', to: 'hr/features#index'

    # profiles 
    get '/profiles', to: 'profiles#index' 

    #checkout route
    post 'checkout/create', to: 'checkout#create'
    post '/checkout/webhooks/stripe', to: 'checkout#webhook_checkout_handle'
    get '/api/stripe/session/:session_id', to: 'stripe_sessions#show'
end
