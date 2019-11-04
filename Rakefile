if ENV['RACK_ENV'] != 'production'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new :spec

  task default: [:setup]
end
require 'pg'
task :setup do
  # connection = PG.connect(dbname: 'chitter_manager_test')
  # PG.connect.exec("DROP DATABASE chitter_manager_test;")
  ['bnb', 'bnb_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{ database };")
    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE hosts(host_id SERIAL PRIMARY KEY, name VARCHAR(20), username VARCHAR(60), password VARCHAR(60));")
    connection.exec("CREATE TABLE accommodation(spaceID SERIAL PRIMARY KEY, host_id INTEGER REFERENCES hosts(host_id),
    spaceName VARCHAR(60), description VARCHAR(400), Price_per_night INTEGER, dates_available VARCHAR(200), availability VARCHAR(6), location VARCHAR(100));")
  end
end
