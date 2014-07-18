require 'sinatra/base'
require 'rdiscount'
require 'mongo'
require 'json/ext'

class GeoJSONClient < Sinatra::Base
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
end