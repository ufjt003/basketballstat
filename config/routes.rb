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

  resources :teams, only: [ :create, :show ] do
    member do
      post '/add_player/:player_id', to: 'teams#add_player'
      post '/remove_player/:player_id', to: 'teams#remove_player'
    end
  end

  resources :games, only: [ :create, :show ] do
    member do
      post '/add_team/:team_id', to: 'games#add_team'
      post '/remove_team/:team_id', to: 'games#remove_team'
    end
  end

end
