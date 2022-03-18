Rails.application.routes.draw do
  devise_for :users
  resources :blogs do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "blogs#index";
end
