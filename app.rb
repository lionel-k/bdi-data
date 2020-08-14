require 'date'
require 'sinatra'
require 'sinatra/json'
require 'pry'

get '/' do
  'Welcome the open data portal on Burundi'
end

get '/exchangerates' do
  data = {
    date: Date.today.strftime('%Y-%m-%d'),
    usd: 1908.013,
    eur: 2254.890,
    dts: 2692.389
  }
  return json data
end

get '/exchangerates/:date' do
  date = params[:date]
  data = {
    date: date,
    usd: 1910,
    eur: 2220,
    dts: 2692
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
