Rails.application.routes.draw do

  devise_for :users
  root 'restaurants#index'

  resources :restaurants do
    resources :reviews, except: [:index, :show]
  end

  match '/about_us', to: 'pages#about_us', via: :get
  match '/contact', to: 'pages#contact', via: :get

end
