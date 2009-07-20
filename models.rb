DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/features.sqlite3")

class Feature
	include DataMapper::Resource
	property :id, Serial
	property :value, String, :unique => true, :scope => :description_id
	belongs_to :description
end

class Description
	include DataMapper::Resource
	property :id, Serial
	property :name, String, :unique => true
	has n, :features
end

# automatically create the tables
[Feature, Description].each do |model|
	model.auto_migrate! unless model.table.exists?
end
