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

    p test_checker()

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

end
