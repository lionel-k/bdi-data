require 'date'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
require "sinatra/reloader" if development?
require 'pry'

set :database_file, 'config/database.yml'

get '/' do
  'Welcome the open data portal on Burundi'
end

get '/exchangerates' do
  today = Date.today
  exchange_rate = ExchangeRate.find_by(date: today)
  if exchange_rate.nil?
    response = { message: 'not available yet' }
    return json response
  end

  currencies = exchange_rate.currencies
  data = { date: today.strftime('%Y-%m-%d') }
  currencies.each { |currency| data[currency.name] = currency.rate }
  return json data
end

get '/exchangerates/:date' do
  date = params[:date]
  data = {
    date: date,
    usd: 1910,
    eur: 2220
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

require './models'
