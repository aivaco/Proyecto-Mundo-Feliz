Rails.application.routes.draw do
  get 'sessions/view_login'
  

=begin get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/new'
=end
#Rutas para facebook
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure' => redirect('/')
  get 'signout' => 'sessions#destroy', as: 'signout'

  root 'pages#mientras'       #Mientras
  get    'login'   => 'sessions#new'
  get  'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users
  
  
end
