Rails.application.routes.draw do

  get 'profile/view'

  get 'administrar_entregable/vistageneral'

  get 'modulo_bitacora/view_bitacora'

  get 'modulo_recurso/view_recurso'

  get 'modulo_entregable/view_entregable'

  get 'password_resets/new'
  get 'password_resets/edit'
  post 'nuevoEntregable' => 'documento#nuevoEntregable'
  post 'entregableSeleccionado' => 'documento#entregableSeleccionado'
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
  
  get 'profile' => 'profile#view'
  
  get 'newclient' => 'new_client#new'
  post 'newclient' => 'new_client#create'
  
  get 'profile' => 'profile#view'
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
  #Muestra información principal del documento de riesgo
  get '/riesgo/:id', to: 'riesgo#show', as: 'riesgo'
  #Muestra información principal del documento de alianza
  get '/alianza/:id', to: 'alianza#show', as: 'alianza'


  post 'borrarEntregableSeleccionado' => 'documento#borrarEntregableSeleccionado'
  
  
  #Administrar recursos de entregables
  get '/recursos_asignados/:id', to: 'recursos_asignados#administrar', as: 'recursos_entregable'
  get 'agregarRecursoSeleccionado' => 'recursos_asignados#agregarRecursoSeleccionado'
  get 'removerRecursoSeleccionado' => 'recursos_asignados#removerRecursoSeleccionado'
  
  
  get 'bitacora/bitacora_usuario'

  get 'bitacora/bitacora_administrador'

  get 'bitacora/ver_bitacora'

  get 'recursos/lista_recursos'

  get 'recursos/agregar_recurso'

  get 'recursos/opciones_recurso'
  post 'formBuscarRecurso' => 'recursos#lista_recursos'
  
  post 'formEnviarReporte' => 'bitacora#bitacora_usuario'
  post 'formCrearRecurso' => 'recursos#lista_recursos'
  post 'formCrearUsuario' => 'recursos#lista_recursos'
  post 'formEditarRecurso' => 'recursos#lista_recursos'
  
end
