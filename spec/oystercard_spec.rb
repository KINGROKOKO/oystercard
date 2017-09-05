require 'OysterCard'

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
    station = double
    expect { subject.touch_out(station) }.to change { subject.balance }.by (-1)
  end

  it 'CHECK TOP UP DOES NOT EXCEED CARD LIMIT' do
    expect { subject.top_up(100) }.to raise_error "OVER YOUR £#{OysterCard::CARD_LIMIT} CARD LIMIT"
  end

  it 'CHECK TOUCH IN CHANGES JOURNEY STATE TO TRUE' do
    kingscross = double
    subject.top_up(5)
    subject.touch_in(kingscross)
    expect(subject.in_journey?).to eq true
  end

  it 'CHECK TOUCH OUT CHANGES JOURNEY STATE TO FALSE' do
    kingscross = double
    subject.top_up(5)
    subject.touch_in(kingscross)
    subject.touch_out(kingscross)
    expect(subject.in_journey?).to eq false
  end

  it 'CHECKS CARD FOR INSUFFICIENT BALANCE' do
    kingscross = double
    expect { subject.touch_in(kingscross) }.to raise_error 'BELOW LIMIT, TOP UP'
  end

  it 'CHECKS ENTRY STATION AFTER TOUCH IN' do
    subject.top_up(5)
    kingscross = double
    subject.touch_in(kingscross)
    expect(subject.entry_station).to eq kingscross
  end

  it 'FORGET STATION NAME ON TOUCH OUT' do
    subject.top_up(5)
    kingscross = double
    subject.touch_in(kingscross)
    subject.touch_out(kingscross)
    expect(subject.entry_station).to eq nil
  end

  it 'CHECK JOURNEY HISTORY' do
    expect(subject.journey_history.empty?).to eq true
  end

  it 'CHECKS TOUCH IN AND OUT STORES ONE JOURNEY' do
    # kingscross = double
    # euston = double
    subject.top_up(5)
    subject.touch_in("kingscross")
    subject.touch_out("euston")
    expect(subject.journey).to eq ({ :journey_start => "kingscross",  :journey_end => "euston" })
  end

  it 'CHECK JOURNEY HISTORY' do
    # kingscross = double
    # euston = double
    subject.top_up(5)
    subject.touch_in("kingscross")
    subject.touch_out("euston")
    expect(subject.journey_history).to eq ([{ :journey_start => "kingscross",  :journey_end => "euston" }])
  end
end
