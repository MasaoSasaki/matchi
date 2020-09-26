Rails.application.routes.draw do

  get '/', to: 'public/homes#top', as: 'root'
  get 'about', to: 'public/homes#about'
  get 'privacy', to: 'public/homes#privacy'
  get 'terms', to: 'public/homes#terms'
  get 'admin', to: 'public/homes#admin'
  get 'redirect', to: 'public/homes#redirect'

  scope :mypage do
    get '/', to: 'public/users#show', as: 'user_mypage'
    get 'edit', to: 'public/users#edit', as: 'user_edit'
    get 'withdraw', to: 'public/users#withdraw', as: 'user_withdraw'
    get 'profile', to: 'public/users#profile', as: 'user_profile'
    get 'info', to: 'public/users#info', as: 'user_info'
  end

  scope :contact do
    post '/', to: 'contacts#create', as: 'contact'
    get 'form', to: 'contacts#new', as: 'new_contact'
    post 'confirm', to: 'contacts#confirm', as: "confirm_contact"
    post 'back', to: 'contacts#back', as: "back_contact"
    post 'completion', to: 'contacts#completion', as: "completion_contact"
  end

  namespace :master do
    devise_for :admins, controllers: {
      sessions: 'master/admins/sessions',
      registrations: 'master/admins/registrations'
    }
    get '/', to: 'admins#top'
    resources :users, only: %i[index show update]
    resources :restaurants, only: %i[index show]
    resources :tags, only: %i[index create destroy]
  end

  namespace :owner do
    devise_for :restaurants, controllers: {
      sessions: 'owner/restaurants/sessions',
      registrations: 'owner/restaurants/registrations'
    }
    resources :restaurants, only: %i[show edit update] do
      resources :menus
    end
    resources :reservations, only: %i[index show update]
    resources :menu_tags, only: %i[create destroy]
  end

   scope module: :public do
    devise_for :users, controllers: {
      sessions: 'public/users/sessions',
      registrations: 'public/users/registrations',
      passwords: 'public/users/passwords'
    }

    devise_scope :user do
      post 'users/sign_up/confirm', to: 'users/registrations#confirm'
      get 'users/sign_up/complete', to: 'users/registrations#complete'
    end

    resources :users, only: %i[update] do
      get 'reservations/confirm', to: 'reservations#confirm'
      get 'reservations/completion', to: 'reservations#completion'
      resources :reservations, only: %i[index show new create]
      resources :bookmarks, only: %i[:index show]
    end

    patch 'users/:id/withdrawal', to: 'users#withdrawal', as: 'users/withdrawal'
    get 'users/:id/withdrew', to: 'users#withdrew', as: 'users/withdrew'
    get 'users/:id/withdraw', to: 'users#withdraw', as: 'users/withdraw'

    resources :restaurants, only: %i[index show]
    resources :menus, only: %i[index show]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
