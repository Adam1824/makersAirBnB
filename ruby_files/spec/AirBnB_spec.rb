require 'AirBnB'
require 'persisted_data'

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

describe '.sign_up' do
  it 'can sign someone up' do
    connection = PG.connect(dbname: 'bnb_test')

    users = Hosts.sign_up(name: "Luke", username: "LukeGittins01", password: "password")


    persisted_data = persisted_data(host_id: users.host_id)
    expect(users.name).to eq 'Luke'
  end
end

describe '.create' do
  it 'can create a new space' do
    connection = PG.connect(dbname: 'bnb_test')

    places = AirBnB.create(spacename: "1 room flat", description: "room with sink and bed", price_per_night: 50, dates_available: "january", availability: "True", location: "leatherhead")
    persisted_data = persisted_dats_create(spaceid: places.spaceid)
    expect(places.spacename).to eq '1 room flat'
    expect(places.description).to eq 'room with sink and bed'
    expect(places.price_per_night).to eq '50'
  end
end
