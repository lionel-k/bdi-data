ENV['APP_ENV'] = 'test'

require './app'
require 'minitest/autorun'
require 'rack/test'

class MyAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_my_default
    get '/'
    assert_equal 'Welcome to Burundi Data',
      JSON.parse(last_response.body)['message']
  end

  # def test_with_params
  #   get '/meet', :name => 'Frank'
  #   assert_equal 'Hello Frank!', last_response.body
  # end

  # def test_with_user_agent
  #   get '/', {}, 'HTTP_USER_AGENT' => 'Songbird'
  #   assert_equal "You're using Songbird!", last_response.body
  # end
end



# require 'app'
# require 'test/unit'
# require 'rack/test'

# class HelloWorldTest < Test::Unit::TestCase
#   include Rack::Test::Methods

#   def app
#     Sinatra::Application
#   end

#   def test_it_says_hello_world
#     get '/'
#     assert last_response.ok?
#     assert_equal 'Hello World', last_response.body
#   end

#   def test_it_says_hello_to_a_person
#     get '/', :name => 'Simon'
#     assert last_response.body.include?('Simon')
#   end
# end
