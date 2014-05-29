Realballerz::Application.routes.draw do
  devise_for :users, skip: [ :session, :registration, :password]
  devise_scope :user do
    post "users/sign_in",    to: "sessions#create"
    delete "users/sign_out", to: "sessions#destroy"
    post "users",            to: "registrations#create"
    put  "users",            to: "registrations#update"
  end

  root :to => "home#index"
  scope 'api' do
    resources :players, only: [ :create, :show, :index ] do
      collection do
        get :not_in_a_team
      end
      member do
        post :two_pointer_attempt
        post :two_pointer_make
        post :three_pointer_attempt
        post :three_pointer_make
        post :free_throw_attempt
        post :free_throw_make
        post :assist
        post :rebound
        post :steal
        post :block
        post :turnover
        post :foul
      end
    end

    resources :teams, only: [ :create, :show, :index ] do
      member do
        get  '/games', to: 'teams#games'
        post '/add_player/:player_id', to: 'teams#add_player'
        post '/remove_player/:player_id', to: 'teams#remove_player'
      end
    end

    resources :games, only: [ :create, :show, :index ] do
      member do
        post '/add_team/:team_id', to: 'games#add_team'
        post '/remove_team/:team_id', to: 'games#remove_team'
        post '/start', to: 'games#start'
        post '/finish', to: 'games#finish'
      end
    end
  end

end
