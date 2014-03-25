class HomeController < ApplicationController
  skip_authorization_check

  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render json: 'realballerz api' }
    end
  end
end
