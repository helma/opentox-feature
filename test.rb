require 'application'
require 'test/unit'
require 'rack/test'

class FeaturesTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_post
    post '/', :name => "Rodent carcinogenicity", :values => { :classification => 'active' }
		assert last_response.ok?
		assert_equal "http://example.org/Rodent%20carcinogenicity/classification/active", last_response.body.chomp
  end

	def test_get_name
		get '/Rodent%20carcinogenicity/classification/active/name'
		assert last_response.ok?
		assert_equal 'Rodent carcinogenicity', last_response.body
	end

	def test_get_activity
		get '/Rodent%20carcinogenicity/classification/active/classification'
		assert last_response.ok?
		assert_equal 'active', last_response.body
	end

end
