class RegistrationsController < Devise::RegistrationsController
  layout "layouts/signup"

  def new
    super
  end
end
