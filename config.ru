require './app'

configure do
  set :protection, except: [:json_csrf]
end

run Sinatra::Application
