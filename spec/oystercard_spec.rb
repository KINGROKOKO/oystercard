require 'oystercard'
require 'station'


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
    expect { subject.touch_out(euston) }.to change { subject.balance }.by(-1)
  end

  it 'CHECK TOP UP DOES NOT EXCEED CARD LIMIT' do
    expect { subject.top_up(100) }.to raise_error "OVER £#{OysterCard::CARD_LIMIT} LIMIT"
  end

  it 'CHECKS CARD FOR INSUFFICIENT BALANCE' do
    kingscross = Station.new('kingscross')
    expect { subject.touch_in(kingscross) }.to raise_error 'BELOW LIMIT'
  end

  it 'CHECKS ENTRY STATION AFTER TOUCH IN' do
    subject.top_up(5)
    kingscross = Station.new('kingscross')
    subject.touch_in(kingscross)
    expect(subject.entry_station).to eq kingscross
  end

  context '**EDGE CASE**'
  it 'CHARGES PENALTY FARE FOR TOUCH OUT WITH NO TOUCH IN' do
    subject.top_up(5)
    station = Station.new('kingscross')
    expect { subject.touch_out(station) }.to change { subject.balance }.by(-6)
  end

  context '**EDGE CASE**'
  it 'CHARGES PENALTY FARE FOR TOUCH IN TWICE IN A ROW WITH NO TOUCH OUT' do
    subject.top_up(10)
    kingscross = Station.new
    subject.touch_in(kingscross)
    expect { subject.touch_in(kingscross) }.to change { subject.balance }.by(-6)
  end
end
