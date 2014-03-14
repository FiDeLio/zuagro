class Api::V1::ProfilesController < Api::V1::TokenAuthController
  respond_to :json

  def update
    data = {}
    data[:name] = params[:name] if params[:name] && params[:name] != ''
    data[:password] = params[:password] if params[:password] && params[:password] != ''
    status = 400
    user = User.update(params[:id], data)
    status = 200 if user
    render :status => status,
           json: {}
  end
end