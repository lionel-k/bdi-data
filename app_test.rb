ENV['SINATRA_ENV'] = 'test'

require './app'
require 'minitest/autorun'
require 'rack/test'

class MyAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_root_url
    get '/'
    assert_equal 'Welcome to Burundi Data',
      JSON.parse(last_response.body)['message']
  end

  def test_current_exchange_rates_not_available
    get '/exchangerates'
    assert_equal 404, last_response.status
    assert_equal 'Exchange Rate not available yet',
      JSON.parse(last_response.body)['message']
  end

  def test_exchange_rates_at_non_present_date_not_available
    get '/exchangerates/1990-01-01'
    assert_equal 404, last_response.status
    assert_equal 'Exchange Rate at this date not available',
      JSON.parse(last_response.body)['message']
  end

  def test_invalid_date
    get '/exchangerates/1243'
    assert_equal 404, last_response.status
    assert_equal 'invalid date - format: year-month-date',
      JSON.parse(last_response.body)['message']
  end

  def test_return_current_rate
    exchange_rate = ExchangeRate.create!(date: Date.today)
    rates = %w[USD EUR].each_with_index.map do |name, index|
      { name: name, buyer: index + 1, seller: index + 2, rate: index + 1.5 }
    end
    exchange_rate.currencies.create!(rates)

    get '/exchangerates'
    assert_equal 200, last_response.status
    # assert_equal 'Exchange Rate not available yet',
      # JSON.parse(last_response.body)['message']
  end
end
