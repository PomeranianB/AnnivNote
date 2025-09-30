Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "/about" => "homes#about", as: 'about'
  get "/users/mypage" => "users#mypage"
  resources :posts, only: [:new, :show, :edit, :index, :destroy]
  resources :users, only: [:show, :edit, :mypage]
  resources :user_images, only: [:new, :create, :mypage, :destroy]
  resources :post_images, only: [:new, :create, :index, :show, :destroy]
end
