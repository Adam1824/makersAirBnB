require 'pg'

def setup_test_database
  p 'Setting up test database'

  connection = PG.connect(dbname: 'bnb_test')
  connection.exec("TRUNCATE accommodation;")
  connection.exec("TRUNCATE hosts;")
end
