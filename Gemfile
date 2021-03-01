# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.6'

# Sinatra
gem 'sinatra'
gem 'sinatra-activerecord', '~> 2.0'
gem 'sinatra-contrib'

# Debugging
gem 'pry'

# Tasks
gem 'nokogiri'
gem 'rake'


group :development do
  gem 'sqlite3'
end

group :production do
   gem 'pg'
   gem 'activerecord-postgresql-adapter'
end

group :test do
  gem 'rack-test'
end
