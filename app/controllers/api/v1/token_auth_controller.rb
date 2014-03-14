class Api::V1::TokenAuthController < ApplicationController
  prepend_before_filter :get_auth_token
  private
  def get_auth_token
    if params[:auth_token].blank? && request.headers["Token"]
      params[:auth_token] = request.headers["Token"]
    end
    user = User.where(authentication_token: params[:auth_token]).first
    status = 403
    if !params[:auth_token].blank?
      status = 401
    end
    if user.nil?
      render status: status,
             json: {}
    else
      @@user_id = user.id
    end
  end
end