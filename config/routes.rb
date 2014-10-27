Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    api_version module: 'V1', path: { value: 'v1' } do
      resources :users, only: [:create, :update, :show]
    end
  end
end
