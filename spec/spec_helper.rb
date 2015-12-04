ENV["RACK_ENV"] ||= "test"
require 'rspec'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'pry'
require_relative '../app.rb'

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.before(:each) do
    database = Sinatra::Application.db_config[:dbname]
    system("dropdb #{database} 2>&1 > /dev/null")
    system("createdb #{database} 2>&1 > /dev/null")
    system("psql #{database} < schema.sql >> /dev/null 2>&1")
  end
end


def expect_no_page_reload
  page.evaluate_script "$(document.body).addClass('not-reloaded')"
  yield
  expect(page).to have_selector("body.not-reloaded"), "Page should not be reloaded"
end
