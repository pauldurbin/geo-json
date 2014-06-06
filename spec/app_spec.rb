require_relative 'spec_helper'

describe 'GeoJSONClient App' do
 it 'should have index page' do
   get '/'
   last_response.must_be :ok?
   last_response.body.must_include "Clive Mansfield's Gym"
 end
 
 it 'should display pretty 404 errors' do
   get '/404'
   last_response.status.must_equal 404
   last_response.body.must_include "Page not found"
 end
end