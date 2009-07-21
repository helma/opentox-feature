ENV['RACK_ENV'] = 'test'
require 'features'
require 'test/unit'
require 'rack/test'

class FeaturesTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_post
    post '/', :name => "Rodent carcinogenicity", :value => 0
		assert last_response.ok?
		assert_equal "http://example.org/Rodent%20carcinogenicity/0", last_response.body.chomp
  end

	def test_get
		get "/Rodent%20carcinogenicity/0"
		assert last_response.ok?
		assert last_response.body.include?('Rodent carcinogenicity')
	end

end
