require 'application'
require 'test/unit'
require 'rack/test'

class FeaturesTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

	def test_feature_xml
		get '/N%2DN/effect/activating/p_value/0.9997.xml'
		#puts last_response.body
		assert last_response.ok?
		# TODO: add test vor xml validation
	end

	def test_feature_yaml
		get '/N%2DN/effect/activating/p_value/0.9997.yaml'
		#puts last_response.body
		assert last_response.ok?
		assert YAML.load(last_response.body)['p_value'] == '0.9997'
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
