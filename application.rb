## SETUP
[ 'rubygems', 'sinatra', 'sinatra/url_for', 'sinatra/respond_to', 'builder' ].each do |lib|
	require lib
end

set :default_content, :yaml

## REST API
get '/:name/*/name' do
	URI.decode(params[:name])
end

get '/:name/*/:property' do
	items = params[:splat][0].split(/\//)
	i = items.index(params[:property])
	pass unless i
	items[i+1]
end

get '/:name/*/?' do

	@feature = {}
	@feature['name'] = params[:name]
	key_value_pairs = params[:splat][0].split(/\//)
	i = 0
	while i < key_value_pairs.size do
		@feature[key_value_pairs[i]] = key_value_pairs[i+1]
		i += 2
	end

	respond_to do |format|
		format.yaml { @feature.to_yaml }
		format.xml {  builder :feature }
	end

end

post '/?' do
	uri = url_for("/#{URI.encode(params[:name])}", :full)
	params[:values].each do |k,v|
		uri += '/' + URI.encode(k) + '/' + v
	end
	uri
end
