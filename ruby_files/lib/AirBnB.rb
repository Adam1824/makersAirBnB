require 'pg'
require_relative 'test_check'

class AirBnB

  attr_reader :spaceid, :host_id, :spacename , :description, :price_per_night, :dates_available, :availability , :location

  def initialize(spaceid:, host_id: , spacename: , description: , price_per_night: , dates_available: , availability: , location:)
    @spaceid = spaceid
    @host_id = host_id
    @spacename = spacename
    @description = description
    @price_per_night = price_per_night
    @dates_available = dates_available
    @availability = availability
    @location = location
  end

  def self.all

    test_checker()

    result = @connection.exec("SELECT * FROM accommodation;")
    result.map do |place|
      AirBnB.new(spaceid: place['spaceid'], host_id: place['host_id'], spacename: place['spacename'], description: place['description'], price_per_night: place['price_per_night'], dates_available: place['dates_available'], availability: place['availability'], location: place['location'])
    end
  end

  def self.create(spacename: , description: , price_per_night: , dates_available: , availability: , location:)

    test_checker()

    result = @connection.exec("INSERT INTO accommodation (spacename, description, price_per_night, dates_available, availability, location) VALUES('#{spacename}', '#{description}', '#{price_per_night}' , '#{dates_available}', '#{availability}', '#{location}') RETURNING spacename, description, price_per_night, dates_available, availability, location")
    AirBnB.new(spaceid: result[0]['spaceid'], host_id: result[0]['host_id'], spacename: result[0]['spacename'], description: result[0]['description'], price_per_night: result[0]['price_per_night'], dates_available: result[0]['dates_available'], availability: result[0]['availability'], location: result[0]['location'])
  end

  def self.update(spaceid)

    test_checker()

    result = @connection.exec("UPDATE accommodation SET availability = False WHERE spaceid = '#{spaceid}'")

  end
end

class Hosts
  attr_reader :host_id, :name, :username, :password
  def initialize(host_id:, name:, username:, password:)
    @host_id = host_id
    @name = name
    @username = username
    @password = password
  end

  def self.sign_up(name:, username:, password:)

    test_checker()

    result = @connection.exec("INSERT INTO hosts (name, username, password) VALUES('#{name}', '#{username}', '#{password}') RETURNING name, username, password")
    Hosts.new(host_id: result[0]['host_id'], name: result[0]['name'], username: result[0]['username'], password: result[0]['password'])
  end

  def self.sign_in(username:, password:)
    test_checker()
    result = @connection.query("SELECT username FROM hosts WHERE username = '#{username}' AND password = '#{password}';")
    output = ""
    result.each do |res|
      output += "#{res['username']}"
    end
    return output
  end

  def self.user_exists(username)
    test_checker()
    users = @connection.query("SELECT username FROM hosts")
    users.each do |user|
      if user['username'] == username
        return true
      end
    end
    return false
  end

  def self.check_sign_in(username:, password:)
    test_checker()
    signed_in = false
    users = @connection.query("SELECT username, password FROM hosts WHERE username = '#{username}' AND password = '#{password}';")
    users.each do |user|
      if username == user["username"] && password == user["password"]
        signed_in = true
      end
    end
    return signed_in
  end
end
