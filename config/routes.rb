Rails.application.routes.draw do

  get '/', to: 'public/homes#top', as: 'root'
  get 'about', to: 'public/homes#about'
  get 'privacy', to: 'public/homes#privacy'
  get 'terms', to: 'public/homes#terms'
  get 'admin', to: 'public/homes#admin'
  get 'redirect', to: 'public/homes#redirect'
  get 'mypage', to: 'public/users#show'
  get 'mypage/edit', to: 'public/users#edit'
  get 'mypage/withdraw', to: 'public/users#withdraw'
  get 'myprofile', to: 'public/users#profile'
  get 'myinfo', to: 'public/users#info'

  scope :contact do
    post '/', to: 'contacts#create', as: 'contact'
    get 'new', to: 'contacts#new', as: 'new_contact'
    get 'confirm', to: 'contacts#confirm', as: "confirm_contact"
    get 'completion', to: 'contacts#completion', as: "completion_contact"
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

  namespace :public do
    devise_for :users, controllers: {
      sessions: 'public/users/sessions',
      registrations: 'public/users/registrations',
      passwords: 'public/users/passwords'
    }
    # get '/', to: 'homes#top'
    resources :users, only: %i[update new] do
      get 'completion', to: 'users#completion'
      get 'reservations/confirm', to: 'reservations#confirm'
      get 'reservations/completion', to: 'reservations#completion'
      resources :reservations, only: %i[index show new create]
      resources :bookmarks, only: %i[:index show]
    end

    patch 'users/:id/withdrawal', to: 'users#withdrawal', as: 'users/withdrawal'
    get 'users/:id/withdrew', to: 'users#withdrew', as: 'users/withdrew'

    resources :restaurants, only: %i[index show]
    resources :menus, only: %i[index show]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
