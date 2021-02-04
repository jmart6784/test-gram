Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations"
  }

  devise_scope :user do
    authenticated :user do
      root 'posts#following_feed', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show]
  post "more_user_index", to: "users#more_user_index", as: :more_user_index
  post "more_user_show_posts/:id", to: "users#more_user_show_posts", as: :more_user_show_posts

  resources :posts
  post "more_index_posts", to: "posts#more_index_posts", as: :more_index_posts

  resources :posts do
    resources :comments, only: [:create, :update, :destroy] do
      member do
        post :ajax_feed_comment
      end
    end
  end

  post "more_comments/:post_id", to: "comments#more_comments", as: :more_comments

  get "/following_feed", to: "posts#following_feed"
  post "more_following_posts/:posts", to: "posts#more_following", as: :more_following

  get "/activity", to: "posts#activity"
  post "more_activity", to: "posts#more_activity", as: :more_activity

  get "/saved_posts", to: "saved_posts#saved_posts"
  post "more_saved_posts", to: "saved_posts#more_saved_posts", as: :more_saved_posts

  resources :video_posts

  resources :video_posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :likes, only: [:update] do
    member do
      put :ajax_likes_update
    end
  end

  resources :follows, only: [:update] do
    member do
      put :ajax_follows_update
    end
  end

  get "followers_index/:id", to: "follows#followers_index", as: :followers_index
  get "following_index/:id", to: "follows#following_index", as: :following_index

  resources :saved_posts, only: [:update] do
    member do
      put :ajax_saved_posts
    end
  end

  resources :conversations do
    resources :messages
  end

  post "more_conversations", to: "conversations#more_conversations", as: :more_conversations
end
