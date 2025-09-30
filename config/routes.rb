Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  get 'users/mypage'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "/about" => "homes#about", as: 'about'
  resources :posts, only: [:new, :show, :edit, :index]
  resources :users, only: [:show, :edit, :mypage]
end
