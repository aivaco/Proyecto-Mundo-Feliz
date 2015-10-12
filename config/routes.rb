Rails.application.routes.draw do
  get 'sessions/new'

=begin get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/new'
=end
  root 'pages#mientras'       #Mientras
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users


  #root 'pages#view_login'
  
  
end
