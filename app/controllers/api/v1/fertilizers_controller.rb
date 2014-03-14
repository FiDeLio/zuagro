class Api::V1::FertilizersController < Api::V1::TokenAuthController
  respond_to :json
  def index
    fertilizers = Fertilizer.all
    list = []
    fertilizers.each { |f|
      list << {
          name: f[:name],
          n_total: f[:n_total],
          n_nh4: f[:n_nh4],
          n_no3: f[:n_no3],
          p2o5: f[:p2o5],
          k20: f[:k20],
          cao: f[:cao],
          s: f[:s],
          mgo: f[:mgo],
          b: f[:b],
          zn: f[:zn],
          na: f[:na]
      }
    }
    render status: 200,
           json: {
               list: list
           }
  end
end