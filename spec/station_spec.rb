require 'station'
require 'oystercard'

describe Station do
  it 'CHECKS STATION NAME' do
    expect(subject.station_name).to eq 'kingscross'
  end

  it 'CHECKS STATION ZONE' do
    expect(subject.zone).to eq 1
  end

  it 'CHARGE 2 FOR A 1 ZONE CHANGE JOURNEY' do
    card = OysterCard.new
    kingscross = Station.new(kingscross, 1)
    euston = Station.new(euston, 2)
    card.top_up(50)
    card.touch_in(kingscross)
    expect{ card.touch_out(euston) }.to change { card.balance }.by(-2)
  end

  it 'CHARGE 3 FOR A 2 ZONE CHANGE JOURNEY' do
    card = OysterCard.new
    kingscross = Station.new(kingscross, 1)
    euston = Station.new(euston, 3)
    card.top_up(50)
    card.touch_in(kingscross)
    expect{ card.touch_out(euston) }.to change { card.balance }.by(-3)
  end

  it 'CHARGE 4 FOR A 3 ZONE CHANGE JOURNEY' do
    card = OysterCard.new
    kingscross = Station.new(kingscross, 1)
    euston = Station.new(euston, 4)
    card.top_up(50)
    card.touch_in(kingscross)
    expect{ card.touch_out(euston) }.to change { card.balance }.by(-4)
  end

end
