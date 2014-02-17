require 'spec_helper'

describe SessionsController, "DELETE destroy" do
  login_user

  context "when current user tries to sign out" do
    it "should be sucessful" do
      delete :destroy, id: @current_user.id
      response.status.should == 200
      response.body.should == { success: 'true', message: 'signed out' }.to_json
    end
  end
end

describe SessionsController, "POST create" do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }
  let (:user) { FactoryGirl.create(:user) }

  context "for valid email/password credentials" do
    it 'should be successful' do
      post :create, user: { email: user.email, password: user.password }
      response.status.should == 200
      result = JSON.parse(response.body)
      result['success'].should == 'true'
      result['email'].should == user.email
    end
  end

  context "for valid email/password credentials" do
    it 'should be fail' do
      post :create, user: { email: user.email, password: "wrong_password" }
      response.status.should == 401
      response.body.should == { errors: ["Invalid login credentials"], success: 'false' }.to_json
    end
  end
end
