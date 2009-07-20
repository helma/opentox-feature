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
  end

  def test_unauthorized_create
    post '/', :name => "Rodent carcinogenicity", :value => 0
		assert last_response.forbidden?
  end

end
