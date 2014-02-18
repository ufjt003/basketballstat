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
      post :shoot
      post :make_field_goal
      post :shoot_three_pointer
      post :make_three_pointer
      post :shoot_free_throw
      post :make_free_throw
      post :assist
      post :rebound
      post :steal
      post :block
      post :turnover
    end
  end
end
