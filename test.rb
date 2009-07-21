ENV['RACK_ENV'] = 'test'
require 'features'
require 'test/unit'
require 'rack/test'



class CompoundsTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_create_feature
		authorize "api", API_KEY
    post '/', :name => "Rodent carcinogenicity", :value => 0
		assert last_response.ok?
		assert_equal "http://example.org/1", last_response.body.chomp
  end

	def test_create_more_features
		authorize "api", API_KEY
    post '/', :name => "Rodent carcinogenicity", :value => 1
    post '/', :name => "Mutagenicity", :value => 0
		assert last_response.ok?
		assert_equal "http://example.org/3", last_response.body.chomp
	end

	def test_create_multiple_features
		authorize "api", API_KEY
    post '/', :name => "Rodent carcinogenicity", :value => 1
		assert last_response.ok?
		assert_equal "http://example.org/2", last_response.body.chomp
	end

	def test_create_more_multiple_features
		authorize "api", API_KEY
    post '/', :name => "Rodent carcinogenicity", :value => 0
		assert last_response.ok?
		assert_equal "http://example.org/1", last_response.body.chomp
	end

	def test_get_index
		get '/'
		assert last_response.ok?
	end

  def test_unauthorized_create
    post '/', :name => "Rodent carcinogenicity", :value => 0
		assert !last_response.ok?
  end

	def test_do_not_create_duplicated_features
		authorize "api", API_KEY
    post '/', :name => "Rat carcinogenicity", :value => 0
		first_uri = last_response.body.chomp
    post '/', :name => "Rat carcinogenicity", :value => 0
		assert_equal first_uri, last_response.body.chomp
	end

end
