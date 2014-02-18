Realballerz::Application.routes.draw do
  devise_for :users, skip: [ :session, :registration, :password]
  devise_scope :user do
    post "users/sign_in",    to: "sessions#create"
    delete "users/sign_out", to: "sessions#destroy"
    post "users",            to: "registrations#create"
    put  "users",            to: "registrations#update"
  end

  root :to => "home#index"
  resources :players, only: [ :create, :show ] do
    member do
      post :shoots
      post :makes_field_goal
      post :shoots_three_pointer
      post :makes_three_pointer
      post :shoots_free_throw
      post :makes_free_throw
    end
  end
end
