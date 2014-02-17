class CustomAuthFailure < Devise::FailureApp
  def respond
    self.status = 401
    self.content_type = 'json'
    self.response_body = { errors: ['Invalid login credentials'], success: 'false' }.to_json
  end 
end
