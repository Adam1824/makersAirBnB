require 'pg'

def persisted_data(host_id:)
  connection = PG.connect(dbname: 'bnb_test')
  result = connection.query("SELECT * FROM hosts WHERE host_id = #{host_id.to_i};")
  result.first
end

def persisted_dats_create(spaceid:)
  connection = PG.connect(dbname: 'bnb_test')
  result = connection.query("SELECT * FROM accommodation WHERE spaceid = #{spaceid.to_i};")
  result.first
end
