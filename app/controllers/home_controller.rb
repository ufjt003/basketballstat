class HomeController < ApplicationController
  skip_authorization_check

  def index
    render json: 'realballerz api'
  end
end
