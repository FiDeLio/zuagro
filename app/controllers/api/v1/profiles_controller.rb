class Api::V1::ProfilesController < Api::V1::TokenAuthController
  respond_to :json
  def index
    render json: params
  end
  def create
    render :status => 200,
           :json => {
               :success => true
           }
  end
  def update
    render :status => 200,
           :json => {
               :success => true
           }
  end
end