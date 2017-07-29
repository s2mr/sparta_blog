Rails.application.routes.draw do
  resources :posts
  root 'posts#index'
  get 'category/:category' => 'posts#index_from_category', as:'category'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
