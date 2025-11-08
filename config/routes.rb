Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch '/users/withdraw' => 'users#withdraw', as: 'withdraw_user'
  put "/users/:id/withdraw" => "users#withdraw", as: 'users_withdraw'
  root to: "homes#top"
  get "/about" => "homes#about", as: 'about'
  get "/users/mypage" => "users#mypage", as: 'mypage'
  patch 'post/:id' => 'posts#update', as: 'update_post'
  resources :posts, only: [:new, :create, :show, :edit, :index, :destroy]
  resources :users, only: [:show, :edit, :update, :destroy, :index,]
  get "search", to: "searches#search"
end
