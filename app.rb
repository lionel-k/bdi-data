# Reads the variables sent via POST
# session_id   = $_POST["sessionId"];
# service_code = $_POST["serviceCode"];
# text = $_POST["text"];

# # This is the first menu screen

# if text == ''
#   response  = 'CON Hi welcome, I can help you with Event Reservation \n'
#   response .= '1. Enter 1 to continue'
#   # $response = "Hello".$_POST;
# end

# header('Content-type: text/plain')
# return response

# require 'rubygems'
# require 'sinatra'

# get '/' do
#   'Hello from Sinatra on Heroku!'
# end
require 'sinatra'
require 'pry'

get '/' do
  'CON Hello world! from GET'
end

post '/' do
  binding.pry
  'CON Hello world! from POST'
end
