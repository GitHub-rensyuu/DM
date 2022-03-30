Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 3.deviseが最初に来てない
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    # resource :favorites, only: [:create,:destroy]
    # resources :book_comments, only: [:create,:destroy]
  end

  resources :users, only: [:index,:show,:edit,:update]

  put 'users/follow/:user_id',to: 'users#follow'
  put 'users/unfollow/:user_id',to: 'users#unfollow'
  get 'users/follow_list/:user_id',to: 'users#follow_list'
  get 'users/follower_list/:user_id',to:'users#follower_list'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# 1.endがない
end
