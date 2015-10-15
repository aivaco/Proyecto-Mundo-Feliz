Rails.application.routes.draw do
  
  get 'modulo_cliente/modulo_cliente'

  get 'modulo_cliente/lista_clientes'

  get 'modulo_cliente/actualizar_proyectos'

  get 'modulo_cliente/nuevo_cliente'

  root  'pages#home'       #Mientras
  
  get 'home' => 'pages#home'

  get 'pages/mientras'
  
end
