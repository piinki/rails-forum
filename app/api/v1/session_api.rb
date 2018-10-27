class V1::SessionAPI < Grape::API
  resources :session do
    desc "Login" do
      detail "User use email and password to login.
      Password at least 8 charcters, have 1 number and special character."
    end

    params do
      requires :email, type: String, allow_blank: false
      requires :password, type: String, allow_blank: false
        # regexp: { value: Settings.validations.password_regex, message: :"employee.password.regexp" }
      optional :remember, type: Boolean
    end

    post do
      status 200
      token = UserToken.generate User.authenticate!(params[:email], params[:password]).id, params[:remember]
      present token
    end

    desc "Log out"
    delete do
      token = UserToken.find_by token: access_token_header

      binding.pry
      
      token ? token.destroy : raise(APIError::Unauthenticated)
      { message: I18n.t("log_out") }
    end
  end
end
