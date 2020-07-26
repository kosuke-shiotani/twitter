Rails.application.routes.draw do
  root "tweets#new"
  resources :tweets, only: [:new, :create] do
    collection do
      get "post"
    end
  end    
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
