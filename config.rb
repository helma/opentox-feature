[ 'rubygems', 'sinatra', 'rest_client', 'sinatra/url_for', 'datamapper', 'dm-validations', 'do_sqlite3', 'api_key', 'models', 'helpers'].each do |lib|
	require lib
end

configure :production, :test do
# reload
end

