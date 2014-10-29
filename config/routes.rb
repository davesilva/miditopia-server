Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    api_version module: 'V1', path: { value: 'v1' } do
    resources :uploads
      resources :users, only: [:create, :update, :show]
      resources :tracks, only: [:index, :show, :create, :update, :destroy]
      resources :uploads, only: [:index, :show, :create, :destroy]
    end
  end
end
