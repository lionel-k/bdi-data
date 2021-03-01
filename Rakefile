require './app'
require 'sinatra/activerecord/rake'

namespace :db do
  task :load_config do
    require './app'
  end
end

desc 'Launch server'
task :s do
  exec 'rackup -p 3000'
end

desc 'Launch console'
task :c do
  Pry.start
end

desc 'Launch console'
task :test do
  exec 'ruby app_test.rb'
end

Dir.glob('lib/tasks/*.rake').each { |r| load r}
