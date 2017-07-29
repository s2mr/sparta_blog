Rails.application.routes.draw do
  resources :posts
  root 'posts#index'
  get 'category/:category' => 'posts#index_from_category', as:'category'
  delete 'category/:category' => 'posts#destroy_from_category', as:'delete_category'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
