Spagro::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end

      resources :profiles

      # PENCA PERO FUNCIONA :S
      scope :sites do
        match '/list' => 'sites#list', via: [:get]
        match '/coordenates' => 'sites#coordenates', via: [:get]
      end
      resources :sites
    end
  end

  scope :ajax do
    match 'grid' => 'ajax#grid', via: [:get]
    match 'dashboard' => 'ajax#dashboard', via: [:get]
  end
  scope :profile do
    match '/' => 'profile#index', via: [:get]
  end
  devise_for :users do

  end
  root to: 'session#index'
end
