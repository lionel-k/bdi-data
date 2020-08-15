require 'date'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
require "sinatra/reloader" if development?
require 'pry'

set :database_file, 'config/database.yml'

get '/' do
  response = { message: 'Welcome to Burundi Data' }
  return json response
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

post '/ussd' do
  session_id = params[:sessionId]
  service_code = params[:serviceCode]
  phone_number = params[:phoneNumber]
  text = params[:text]

  puts params

  puts "text: #{text} by #{phone_number}"

  if text == ''
    response  = "CON Karibu kuri Burundi Data? \n"
    response += "Twobafasha gute ? \n"
    response += "1. Amafaranga avunjwa gute ? \n"
    response += '2. Haraza kurwa imvura ?'

  elsif text == '1'
    exchange_rate = ExchangeRate.find_by(date: Date.today)
    rates = JSON.parse(return_currencies(exchange_rate))
    rates = rates.map { |k, v| "#{k}: #{v}" }.join("\n")
    response = "END #{rates}"

  elsif text == '2'
    will_rain  = 'Ego'
    response = "CON Uri muri ntara iyahe ?"

  elsif text.match(/2\*\w+/)
    region = text.match(/2\*(\w+)/)[1]
    will_rain  = ['Ego', 'Oya'].sample
    response = "END Mu ntara ya #{region} : #{will_rain}"
  end

  body response
  status 200
end

def return_currencies(exchange_rate)
  currencies = exchange_rate.currencies
  data = { date: exchange_rate.date.strftime('%Y-%m-%d') }
  currencies.each { |currency| data[currency.name] = currency.rate }
  return json data
end

require './models'
