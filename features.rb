## SETUP
[ 'rubygems', 'sinatra', 'sinatra/url_for', 'builder' ].each do |lib|
	require lib
end

## REST API
get '/' do
	status 404
	"No index available for this component."
end

get '/:name/:value' do
	begin
		builder do |xml|
			xml.instruct!
			xml.feature do
				xml.name params[:name]
				xml.value params[:value]
			end
		end
	rescue
		status 500
		"Cannot create XML."
	end
end

# return canonical uri
post '/' do
	begin
		url_for("/", :full) + URI.encode(params[:name]) + '/' + URI.encode(params[:value])
	rescue
		status 500
		"Failed to create canonical URI for name #{params[:name]} and value #{params[:value]}."
	end
end

delete '/*' do
	status 404
	"Cannot delete - features are not stored permanently"
end
