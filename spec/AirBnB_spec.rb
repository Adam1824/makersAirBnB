require 'AirBnB'

describe '.all' do
  it 'returns all places' do
    connection = PG.connect(dbname: 'bnb_test')


    place = AirBnB.create(spacename: "2 Bedroom house", description: "What a lovely house", price_per_night: 200, dates_available: "December", availability: "True", location: "Solihull")
    AirBnB.create(spacename: "Wooden Lodge", description: "In the middle of a forest", price_per_night: 150, dates_available: "November", availability: "False", location: "Sherwood")


    place = AirBnB.all

    expect(place.length).to eq 2
    expect(place.first).to be_a AirBnB
    expect(place.first.spaceid).to eq place.first.spaceid
    expect(place.first.spacename).to eq '2 Bedroom house'
    expect(place.first.price_per_night).to eq "200"
    expect(place.first.location).to eq 'Solihull'
  end
end
