class Api::V1::SitesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    sites = params[:sites]
    # CREO LA INSTANCIA
    Instance.create(json: sites.to_s, company_id: 1)

    #CREO EL SITIO O PREDIO
    site = Site.create(company_id: 1, name: sites[:name], activated: true)
    sites[:items].each{|i|
      ItemsSite.create(lat: i[:lat], lng: i[:lng], speed: i[:speed], site_id: site[:id], ts: DateTime.strptime((i[:ts].to_i/1000).to_s,'%s'))
    }
    render json: {
        result: 'OK'
    }
  end

  def list
    site = Site.all.order(:name)
    list = []
    site.each{|s|
      list << {
          id: s[:id],
          name: s[:name]
      }
    }
    render json: {
        result: 'OK',
        list: list
    }
  end

  def coordenates
    items_site = ItemsSite.where(site_id: params[:site_id]).order(:ts)
    list = []
    items_site.each{|i|
      list << {
          lat: i[:lat],
          lng: i[:lng],
          ts: i[:ts],
          speed: i[:speed]
      }
    }
    render json: {
        result: 'OK',
        list: list
    }
  end
end