class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  def create
    build_resource
    resource = User.new(params[:user])
    resource.skip_confirmation!
    if resource.save
      sign_in resource
      render :status => 200,
             :json => { :success => true,
                        :info => "Registered",
                        :data => { :user => resource,
                                   :auth_token => current_user.authentication_token } }
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => resource.errors,
                        :data => {} }
    end
  end
end