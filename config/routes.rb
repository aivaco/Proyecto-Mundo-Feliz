Rails.application.routes.draw do
  
  root  'pages#mientras'       #Mientras
  
  get 'home' => 'pages#home'

  
end
