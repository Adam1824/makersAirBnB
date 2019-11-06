require 'AirBnB'

describe '.all' do
  it 'returns all places' do
    connection = PG.connect(dbname: 'bnb_test')


    places = AirBnB.create(spacename: "2 Bedroom house", description: "What a lovely house", price_per_night: 200, dates_available: "December", availability: "True", location: "Solihull")
    AirBnB.create(spacename: "Wooden Lodge", description: "In the middle of a forest", price_per_night: 150, dates_available: "November", availability: "False", location: "Sherwood")


    places = AirBnB.all

    expect(places.length).to eq 2
    expect(places.first).to be_a AirBnB
    expect(places.first.spaceid).to eq places.first.spaceid
    expect(places.first.spacename).to eq '2 Bedroom house'
    expect(places.first.price_per_night).to eq "200"
    expect(places.first.location).to eq 'Solihull'
  end
end
