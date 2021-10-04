Rails.application.routes.draw do
  root 'homes#top'
  devise_for :end_users
  resources :end_users, only: [:index, :show, :edit, :update]
  get 'mypage/:id' => 'end_users#mypage', as: 'mypage'
end
