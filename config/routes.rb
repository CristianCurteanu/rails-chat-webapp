Rails.application.routes.draw do

  # Users
  get  '/register' => 'users#new'
  post '/register' => 'users#create'

  # Sessions
  get  '/login'    => 'sessions#new'
  post '/login'    => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/chats' => 'rooms#all'
  get '/chat/:foreign_id' => 'rooms#show', as: :user_chat

  root to: 'sessions#new'
  mount ActionCable.server => '/cable'
end
