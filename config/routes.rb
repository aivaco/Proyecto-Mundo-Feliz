Rails.application.routes.draw do

  get 'modulo_bitacora/view_bitacora'

  get 'modulo_recurso/view_recurso'

  get 'modulo_entregable/view_entregable'

  get 'password_resets/new'
  get 'password_resets/edit'

=begin 
  
  root  'pages#mientras'       #Mientras
  
  get 'home' => 'pages#home'

=end

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
  #Para activar la cuenta.
  resources :account_activations, only: [:edit]
  #Para reiniciar contraseña.
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  get 'modulo_cliente/modulo_cliente'
  get 'modulo_cliente/nuevo_cliente'
  get 'modulo_cliente/actualizar_proyectos' 
  get 'modulo_cliente/lista_clientes'
  post 'formBuscarCliente' => 'modulo_cliente#lista_clientes'
  
  get 'signup' => 'signup#new'
  post 'signup' => 'signup#create'
  
  get 'newclient' => 'new_client#new'
  post 'newclient' => 'new_client#create'
  #Prueba
  get 'modulo_portafolio/view_portafolio'
  #Para crear una ruta con el nombre home
  get 'home' => 'pages#home', :as => "home"
  
  get '/documento/:id', to: 'documento#show', as: 'documento'
  
end
