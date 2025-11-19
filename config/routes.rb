Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy, :show]
    resources :post_comments, only: [:index, :destroy]
    resources :posts, only: [:show]
    resources :groups, only: [:index, :destroy]
  end

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
  resources :posts, only: [:new, :create, :show, :edit, :index, :destroy, :update] do
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :destroy, :index] do
    resources :post_comments, only: [:create, :destroy, :mypage]
  end
  get "search", to: "searches#search"
  get "/groups/mygroup" => "groups#mygroup", as: 'mygroup'
  resources :groups, only: [:index, :new, :create, :edit, :update, :show, :destroy] do
    resource :permits, only: [:create, :destroy] 
    resource :group_users, only: [:create, :destroy]
  end
  get "groups/:id/permits" => "groups#permits", as: :permits
end
