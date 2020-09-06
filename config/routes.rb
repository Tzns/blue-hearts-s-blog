Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get 'home/info'
  get 'home/test'
  post '/home/_getIndexPageData'
  
  get 'back/index'
  get 'back/word'
  post '/back/_insert_blog'
  post '/back/_update_blog'
  post '/back/_del_blog'
  
  devise_for :sys_users
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
