class Api::V1::SitesController < Api::V1::TokenAuthController

  def create
    sites = params[:sites]
    # CREO LA INSTANCIA
    Instance.create(json: sites.to_s, user_id: @@user_id)

    #CREO EL SITIO O PREDIO
    site = Site.create(user_id: @@user_id, name: sites[:name], activated: true)
    sites[:items].each{|i|
      ItemsSite.create(
          lat: i[:lat],
          lng: i[:lng],
          speed: i[:speed],
          site_id: site[:id],
          ts: DateTime.strptime((i[:ts].to_i/1000).to_s,'%s'),
          accuracy: i['accuracy'],
          altitude: i['altitude'],
          bearing: i['bearing']
      )
    }
    render status: 201,
           json: { }
  end

  def list
    site = Site.where(user_id: @@user_id).order(:name)
    list = []
    site.each{|s|
      list << {
          id: s[:id],
          name: s[:name],
          created_at: s[:created_at]
      }
    }
    render status: 200,
           json: {
               list: list
           }
  end
  def update
    sites = Site.update(params[:id], { name: params[:params][:name], comments: params[:params][:comments]})
    status = 400
    status = 200 if sites
     render status: status,
            json: { }
  end
  def coordenates
    items_site = ItemsSite.where(site_id: params[:site_id]).order(:ts)
    items_site = items_site.where("accuracy <= #{params[:accuracy]}") if params[:accuracy]
    list = []
    items_site.each{|i|
      list << {
          lat: i[:lat],
          lng: i[:lng],
          ts: i[:ts],
          speed: i[:speed],
          accuracy: i[:accuracy]
      }
    }
    render json: {
        result: 'OK',
        list: list
    }
  end
end