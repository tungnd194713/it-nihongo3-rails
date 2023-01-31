Rails.application.routes.draw do
  resources :book_reviews
  root to: 'static_pages#home'
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  get 'users/show'
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
