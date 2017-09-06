require 'OysterCard'
require 'Station'

describe OysterCard do
  it 'CHECK OYSTER CARD BALANCE' do
    expect(subject.balance).to eq 0
  end

  it 'TOP UP CARD' do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end

  it 'DEDUCT MONEY FROM CARD' do
    subject.top_up(10)
    subject.send(:deduct, 5)
    expect(subject.balance).to eq 5
  end

  it 'CHARGE CARD FARE AND DEDUCT AMOUNT' do
    subject.top_up(5)
    kingscross = Station.new('kingscross')
    euston = Station.new('euston')
    subject.touch_in(kingscross)
    expect { subject.touch_out(euston) }.to change { subject.balance }.by (-1)
  end

  it 'CHECK TOP UP DOES NOT EXCEED CARD LIMIT' do
    expect { subject.top_up(100) }.to raise_error "OVER YOUR £#{OysterCard::CARD_LIMIT} CARD LIMIT"
  end

  it 'CHECK TOUCH IN CHANGES JOURNEY STATE TO TRUE' do
    kingscross = Station.new('kingscross')
    subject.top_up(5)
    subject.touch_in(kingscross)
    expect(subject.in_journey).to eq true
  end

  it 'CHECK TOUCH OUT CHANGES JOURNEY STATE TO FALSE' do
    kingscross = Station.new('kingscross')
    subject.top_up(5)
    subject.touch_in(kingscross)
    subject.touch_out(kingscross)
    expect(subject.check).to eq false
  end

  it 'CHECKS CARD FOR INSUFFICIENT BALANCE' do
    kingscross = Station.new('kingscross')
    expect { subject.touch_in(kingscross) }.to raise_error 'BELOW LIMIT, TOP UP'
  end

  it 'CHECKS ENTRY STATION AFTER TOUCH IN' do
    subject.top_up(5)
    kingscross = Station.new('kingscross')
    subject.touch_in(kingscross)
    expect(subject.entry_station).to eq kingscross
  end

  it 'FORGET STATION NAME ON TOUCH OUT' do
    subject.top_up(5)
    kingscross = Station.new('kingscross')
    subject.touch_in(kingscross)
    subject.touch_out(kingscross)
    expect(subject.check).to eq false
  end

  it 'CHECK JOURNEY HISTORY' do
    expect(subject.journey.journey_history.empty?).to eq true
  end

  it 'CHECKS TOUCH IN AND OUT STORES ONE JOURNEY' do
    subject.top_up(5)
    kingscross = Station.new('kingscross')
    euston = Station.new('euston')
    subject.touch_in(kingscross.station_name)
    subject.touch_out(euston.station_name)
    expect(subject.journey.journey_history).to eq ([{ :journey_start => kingscross.station_name,  :journey_end => euston.station_name }])
  end

  it 'CHECK JOURNEY HISTORY' do
    kingscross = Station.new('kingscross')
    euston = Station.new('euston')
    subject.top_up(5)
    subject.touch_in(kingscross.station_name)
    subject.touch_out(euston.station_name)
    expect(subject.journey.journey_history).to eq ([{ :journey_start => kingscross.station_name,  :journey_end => euston.station_name }])
  end

  context '**EDGE CASE**'
  it 'CHARGES PENALTY FARE FOR TOUCH OUT WITH NO TOUCH IN' do
    subject.top_up(5)
    station = Station.new('kingscross')
    expect { subject.touch_out(station) }.to change { subject.balance }.by (-6)
  end

  context '**EDGE CASE**'
  it 'CHARGES PENALTY FARE FOR TOUCH IN TWICE IN A ROW WITH NO TOUCH OUT' do
    subject.top_up(5)
    station = Station.new('kingscross')
    subject.touch_in(double)
    expect { subject.touch_in(station) }.to change { subject.balance }.by (-6)
  end
end
