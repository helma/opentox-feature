## SETUP
[ 'rubygems', 'sinatra', 'rest_client', 'sinatra/url_for', 'datamapper', 'dm-more', 'do_sqlite3', 'builder', 'api_key' ].each do |lib|
	require lib
end

@db = "features.sqlite3"

configure :test do
	@db = "test.sqlite3"
end

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/#{@db}")

puts @db

# reload

## MODELS
#require 'models'
class Feature
	include DataMapper::Resource
	property :id, Serial
	property :value, String
	belongs_to :description
	#has n, :users, :through => Resource
end

class Description
	include DataMapper::Resource
	property :id, Serial
	property :name, String
	has n, :features
end

=begin
class User
	include DataMapper::Resource
	property :id, Serial
	property :name, String, :unique => true
	has n, :features, :through => Resource
end
=end

# automatically create the tables
unless FileTest.exists?("#{@db}")
	[Feature, Description].each do |model|
		model.auto_migrate!
	end
end

## Authentification
helpers do

  def protected!
    response['WWW-Authenticate'] = %(Basic realm="Testing HTTP Auth") and \
    throw(:halt, [401, "Not authorized\n"]) and \
    return unless authorized?
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['api', API_KEY]
  end

end

## REST API
get '/' do
	Feature.all.collect{ |f| url_for("/", :full) + f.id.to_s }.join("\n")
end

get '/:id' do
	feature = Feature.get(params[:id])
	builder do |xml|
    xml.instruct!
    xml.feature do
      xml.name feature.description.name
      xml.value feature.value
    end
  end
end

post '/' do
	protected!
	description = Description.find_or_create :name => params[:name]
	feature = Feature.find_or_create(:value => params[:value].to_s, :description_id => description.id)
	#puts feature.to_yaml
	#feature = Feature.new(:value => params[:value].to_s, :description_id => description.id) unless feature.nil?
	# create association with user
	
	#feature.save
	#unless description.nil? or feature.nil?
		url_for("/", :full) + feature.id.to_s
	#else
		#status 500
		#"Failed to create new feature."
	#end
end

delete '/:id' do
	protected!
	# dangerous, because other datasets might refer to it
	status 401
	"You can not delete features, because other datasets might need them."
	# maybe
	#client = referrer.uri
	#feature = Feature.get(:id)
	# delete association
	#feature.destroy if feature.referenceѕ.nil?
end

#post '/user' do
	#protected_by_root!
#end
