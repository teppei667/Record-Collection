Rails.application.routes.draw do
  root 'homes#top'
  devise_for :end_users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
