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
    response = { message: 'Exchange Rate not available yet' }
    return json response
  end

  return_currencies(exchange_rate)
end

get '/exchangerates/:date' do
  begin
     date = Date.strptime(params[:date],"%Y-%m-%d")
  rescue ArgumentError
     response = { message: 'invalid date - format: year-month-date' }
     return json response
  end

  exchange_rate = ExchangeRate.find_by(date: date)
  if exchange_rate.nil?
    response = {
      date: date,
      message: 'Exchange Rate at this date not available'
    }
    return json response
  end

  return_currencies(exchange_rate)
end

post '/' do
  session_id   = params['sessionId']
  service_code = params['serviceCode']
  phone_number = params['phoneNumber']
  network_code = params['networkCode']
  text = params['text']
  response = "CON Hi welcome, I can help you with Event Reservation \n"
end

def return_currencies(exchange_rate)
  currencies = exchange_rate.currencies
  data = { date: exchange_rate.date.strftime('%Y-%m-%d') }
  currencies.each { |currency| data[currency.name] = currency.rate }
  return json data
end

require './models'
