require 'date'
require 'sinatra'
require 'sinatra/json'
require 'pry'

get '/' do
  'CON Hello world! from GET'
end

get '/exchange_rates' do
  data = {
    date: Date.today.strftime('%d-%m-%Y'),
    usd: {
      buyer: 1908.013,
      seller: 1938.79
    },
    eur: {
      buyer: 2254.890,
      seller: 2291.26
    },
    dts: {
      buyer: 2692.389,
      seller: 2735.81
    }
  }
  return json data
end

post '/' do
  session_id   = params['sessionId']
  service_code = params['serviceCode']
  phone_number = params['phoneNumber']
  network_code = params['networkCode']
  text = params['text']
  response = "CON Hi welcome, I can help you with Event Reservation \n"
end
