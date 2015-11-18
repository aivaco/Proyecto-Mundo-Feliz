Rails.application.routes.draw do

  get 'administrar_entregable/vistageneral'

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
  #Muestra información principal del proyecto
  get '/documento/:id', to: 'documento#show', as: 'documento'
  #Rutas para crear documentos
  match '/alianza/create' => 'alianza#create', :as => :create_alianza, :via => [:post]
  match '/riesgo/create' => 'riesgo#create', :as => :create_riesgo, :via => [:post]
  #Rutas para borrar documentos
  match '/alianza/delete' => 'alianza#delete', :as => :delete_alianza, :via => [:post]
  match '/riesgo/delete' => 'riesgo#delete', :as => :delete_riesgo, :via => [:post]
  #Ruta para agregar una entrega de un entregable
  match '/modulo_entregable/agregar_entrega' => 'modulo_entregable#agregar_entrega', :as => :agregar_entrega, :via => [:post]
  #Rtuas para agregar o eliminar documentos
  get '/documento/add_documento/:id_proyecto', to: 'documento#add_documento', as: 'add_documento'

end
