Rails.application.routes.draw do
  devise_for :users
root to: "home#index"
  use_doorkeeper
 namespace :api do
    namespace :alexa do
      resource :handler, only: [:create]
    end
  end
end