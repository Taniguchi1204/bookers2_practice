Rails.application.routes.draw do
  get 'chats/show'

  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only:[:create,:destroy]
    get "following" => "relationships#following"
    get "followed" => "relationships#followed"

  end
  resources :books do
    resource :favorites, only:[:create,:destroy]
    resources :book_comments, only:[:create,:destroy]
  end
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get "search" => "search#search"

  resources :groups, only:[:show,:index,:new,:create,:edit,:update]
  resources :chats, only:[:show,:create]
end