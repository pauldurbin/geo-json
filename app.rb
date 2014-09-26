require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'

configure do
  MongoMapper.database = 'geo-json'
end

class Service
  include MongoMapper::Document

  key :service_id,  String
  key :location,    Array
  key :properties,  Hash
  key :type,        String

  def icon
    "/images/icons/#{type}.png"
  end

  ensure_index [[:location, '2d']]
end

class GeoJSONClient < Sinatra::Base
  get '/geo/services.geojson' do
    content_type :json
    type = params[:type].blank? ? [] : params[:type].split(',')
    @services = if type.size > 0
      Service.where(type: type, :location => {"$within" => {"$box" => box}})
    else
      Service.where(:location => {"$within" => {"$box" => box}})
    end

    {
      "type" => "FeatureCollection",
      "features" => @services.map do |s|
        {
          "type" => "Feature",
          "id" => s.service_id,
          "geometry" => {
            "type" => "Point",
            "coordinates" => s.location.reverse
          },
          "properties" => s.properties.merge({icon: s.icon})
        }
      end
    }.to_json
  end

  get '/:file?' do
    begin
      file = params[:file] || 'index'
      markdown file.to_sym, :layout_engine => :erb
    rescue Errno::ENOENT
      not_found
    end
  end

  not_found do
    markdown :not_found, :layout_engine => :erb
  end

  def box
    [format_latlng(params[:ne]), format_latlng(params[:sw])]
  end

  def format_latlng(coordinate)
    coordinate.split(',').map { |c| c.to_f }
  end
end
