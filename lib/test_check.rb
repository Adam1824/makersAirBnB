def test_checker
  if ENV['ENVIRONMENT'] == 'test'
    return @connection = PG.connect(dbname: 'bnb_test')
  else
    return @connection = PG.connect(dbname: 'bnb')
  end
end
