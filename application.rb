require 'rubygems'
require 'opentox-ruby-api-wrapper'

set :default_content, :yaml

## REST API
get '/*/?' do
	@feature = OpenTox::Feature.new(:uri => request.url)
	{ :name => @feature.name,
		:uri => @feature.uri,
		:values => @feature.values }.to_yaml
	#respond_to do |format|
		#format.yaml { @feature.to_yaml }
		#format.xml {  builder :feature }
	#end
end

post '/?' do
	OpenTox::Feature.new(params).uri
end
