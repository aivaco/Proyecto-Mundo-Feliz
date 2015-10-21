Rails.application.routes.draw do
=begin <<<<<<< HEAD
  
  root  'pages#mientras'       #Mientras
  
  get 'home' => 'pages#home'

=end ======
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


  root 'pages#home' 

  get    'login'   => 'sessions#new'
  post  'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  
get 'modulo_cliente/modulo_cliente'
  get 'modulo_cliente/nuevo_cliente'
  get 'modulo_cliente/actualizar_proyectos'
  get 'modulo_cliente/lista_clientes'
  
  post 'formBuscarCliente' => 'modulo_cliente#lista_clientes'
  
end
