require 'rack/test'
require 'rspec'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../lib/app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |c|
  c.include RSpecMixin

  c.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  c.before(:each) { DatabaseCleaner.start }
  c.after(:each) { DatabaseCleaner.clean }

  c.color = true
end
