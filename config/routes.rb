Rails.application.routes.draw do
  get 'chats/show'

  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only:[:create,:destroy]
    get "following" => "relationships#following"
    get "followed" => "relationships#followed"
    get "search" => "users#search"
  end
  resources :books do
    resource :favorites, only:[:create,:destroy]
    resources :book_comments, only:[:create,:destroy]
  end
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get "search" => "search#search"

  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  resources :chats, only:[:show,:create]

  get "homes/search" => "homes#search"
end