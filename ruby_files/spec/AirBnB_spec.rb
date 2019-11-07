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

describe '.exists?' do
  context 'someone who has signed up before'
    it 'should return true as they have signed up' do
    connection = PG.connect(dbname: 'bnb_test')
    user = Hosts.sign_up(name: "Luke", username: "LukeGittins01", password: "password")

    expect(user.exists?).to eq(true)
  end

  context 'someone who hasnt signed up before'
  it 'should return false as they havent signed up' do
    connection = PG.connect(dbname: 'bnb_test')
    user = Hosts.new(host_id: 20, name: 'Adam', username: 'adam_f', password: '123')

    expect(user.exists?).to eq(false)
  end
end

describe '.sign_in' do
  context 'someone can sign in'
  it 'should sign in' do
    connection = PG.connect(dbname: 'bnb_test')
    user = Hosts.sign_up(name: "Luke", username: "LukeGittins01", password: "password")

    expect(Hosts.sign_in(username: user.username, password: user.password)).to eq("LukeGittins01")
  end
end

describe '.sign_in_check' do
  it 'should check if the user is signed in' do
    connection = PG.connect(dbname: 'bnb_test')
    user = Hosts.sign_up(name: "Luke", username: "LukeGittins01", password: "password")

    expect(Hosts.sign_in_check(username: user.username, password: user.password)).to eq(true)
  end
end
