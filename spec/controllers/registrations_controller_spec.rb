require 'spec_helper'

describe RegistrationsController, "POST create" do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  context "when email and password are passed" do
    it 'should be successful' do
      user = FactoryGirl.build(:user)
      expect {
        post :create, user: { email: user.email, password: user.password, name: user.name }
        response.status.should == 201
      }.to change(User, :count).by(1)
    end
  end

  context "when password is not passed" do
    it "should fail and return error message" do
      user = FactoryGirl.build(:user)
      expect {
        post :create, user: { password: user.password }
        response.status.should == 400
        response.body.should == { email: ["can't be blank"], name: ["can't be blank"] }.to_json
      }.to change(User, :count).by(0)
    end
  end
end

describe RegistrationsController, "POST update" do
  login_user

  it 'should be successful' do
    old_password = @current_user.password
    post :update, id: @current_user.id, user: { email: "new_email@email.com" }
    response.status.should == 200
    @current_user.reload.email.should == "new_email@email.com"
    @current_user.password.should == old_password
  end

  context "when trying to change invalid password" do
    it " should fail and return error message" do
      post :update, id: @current_user.id, user: { password: "1234" }
      response.status.should == 400
      response.body.should == {password: ["is too short (minimum is 8 characters)"]}.to_json
    end
  end
end
