class SessionController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user
  layout :layout_authenticate
  def change_password

  end
  def reset_password
    flash[:danger] = nil
    flash[:success] = nil
    flash[:warning] = nil
    encrypted_password = BCrypt::Engine.hash_secret(params[:password1], current_rbo_user.salt)
    if encrypted_password != current_rbo_user.encrypted_password
      flash[:danger] = 'try again'
    else
      if params[:password2] != params[:password]
        flash[:warning] = 'Passwords do not match, try again'
      else
        flash[:success] = 'Todo Bien'
      end
    end
    render action: 'change_password'
  end

  def index

  end
  def authenticate_user
    if !user_signed_in?
      redirect_to '/users/sign_in' if params[:controller] != 'devise/sessions'
    else
      Rails.logger.info params[:controller]
      if params[:controller] == 'session'
        #redirect_to current_user.role.open_path
      end
    end
  end

  private
  def layout_authenticate
    if !user_signed_in?
      'login'
    else
      'session'
    end
  end
end