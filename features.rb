require 'config'

# REST API
get '/' do
	Feature.all.collect{ |f| url_for("/", :full) + f.id.to_s }.join("\n")
end

get '/:id' do
	Feature.get(:id).to_xml
end

post '/' do
	protected!
	description = Description.new(:name => params[:name]) unless description = Description.first(:name => params[:name])
	feature = Feature.new(:value => params[:value].to_s) unless feature = Feature.first(:value => params[:value].to_s)
	feature.description = description
	feature.save
	url_for("/", :full) + feature.id.to_s
end

delete '/:id' do
	protected!
	# dangerous, because other datasets might refer to it
	status 401
	"You can not delete features, because other datasets might need them."
end
