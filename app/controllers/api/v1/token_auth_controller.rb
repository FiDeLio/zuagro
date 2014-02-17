class Api::V1::TokenAuthController < ApplicationController
  prepend_before_filter :get_auth_token

  private
  def get_auth_token
    if auth_token = params[:auth_token].blank? && request.headers["HTTP_AUTHORIZATION"]
      params[:auth_token] = auth_token.split.last.unpack('m').first.chop
    end
    user = User.where(authentication_token: params[:auth_token]).first
    if user.nil?
      render json: {
          error: "Session expirada"
      }
    end
  end
end