## SETUP
[ 'rubygems', 'sinatra', 'sinatra/url_for', 'builder' ].each do |lib|
	require lib
end

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

get '/:name/*' do
	key_value_pairs = params[:splat][0].split(/\//)
	i = 0
	values = {}
	while i < key_value_pairs.size do
		values[key_value_pairs[i]] = key_value_pairs[i+1]
		i += 2
	end
	values.to_yaml
=begin
	builder do |xml|
		xml.instruct!
		xml.feature do
			xml.name URI.decode(params[:name])
			values.each do |k,v|
				xml.property do
					xml.name k
					xml.value v
				end
			end
		end
	end
=end
end

post '/?' do
	uri = url_for("/#{URI.encode(params[:name])}", :full)
	params[:values].each do |k,v|
		uri += '/' + URI.encode(k) + '/' + v
	end
	uri
end
