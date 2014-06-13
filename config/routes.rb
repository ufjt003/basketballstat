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
        put :two_pointer_attempt
        put :two_pointer_make
        put :three_pointer_attempt
        put :three_pointer_make
        put :free_throw_attempt
        put :free_throw_make
        put :assist
        put :rebound
        put :steal
        put :block
        put :turnover
        put :foul
        put :undo
      end
    end

    resources :teams, only: [ :create, :show, :index, :destroy ] do
      member do
        get  '/games', to: 'teams#games'
        post '/add_player/:player_id', to: 'teams#add_player'
        post '/remove_player/:player_id', to: 'teams#remove_player'
      end
    end

    resources :games, only: [ :create, :show, :index, :destroy ] do
      member do
        post '/add_home_team/:team_id', to: 'games#add_home_team'
        post '/add_away_team/:team_id', to: 'games#add_away_team'
        post '/remove_team/:team_id', to: 'games#remove_team'
        put '/start', to: 'games#start'
        put '/finish', to: 'games#finish'
        put '/restart', to: 'games#restart'
        get  '/home_team_stat', to: 'games#home_team_stat'
        get  '/away_team_stat', to: 'games#away_team_stat'
        get  '/home_player_stats', to: 'games#home_player_stats'
        get  '/away_player_stats', to: 'games#away_player_stats'
        get  '/home_team_players', to: 'games#home_team_players'
        get  '/away_team_players', to: 'games#away_team_players'
        put '/player_entry/:player_id', to: 'games#player_entry'
        put '/player_leave/:player_id', to: 'games#player_leave'
      end
    end
  end

end
