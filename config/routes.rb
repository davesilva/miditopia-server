Rails.application.routes.draw do
  api_version module: 'V1', path: { value: 'v1' }, defaults: { format: :json } do
    resources :uploads
    resources :users, only: [:create, :update, :show]
    resources :tracks, only: [:index, :show, :create, :update, :destroy]
    resources :uploads, only: [:index, :show, :create, :destroy]
  end
end
