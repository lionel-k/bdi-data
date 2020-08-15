require './app'
require 'sinatra/activerecord/rake'

namespace :db do
  task :load_config do
    require './app'
  end
end

desc 'run irb console'
task :s do
  exec 'rackup -p 3000'
end

Dir.glob('lib/tasks/*.rake').each { |r| load r}
