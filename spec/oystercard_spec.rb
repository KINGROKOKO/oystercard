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
    subject.deduct(5)
    expect(subject.balance).to eq 5
  end

  it 'CHECK TOP UP DOES NOT EXCEED CARD LIMIT' do
    expect{subject.top_up(100)}.to raise_error "OVER YOUR £#{OysterCard::CARD_LIMIT} CARD LIMIT"
  end

  it 'CHECK TOUCH IN CHANGES JOURNEY STATE TO TRUE' do
    subject.top_up(5)
    subject.touch_in
    expect(subject.in_journey).to eq true
  end

  it 'CHECK TOUCH OUT CHANGES JOURNEY STATE TO FALSE' do
    subject.top_up(5)
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey).to eq false
  end

  it 'CHECKS CARD FOR INSUFFICIENT BALANCE' do
    expect{subject.touch_in}.to raise_error 'YOU ARE BELOW YOUR LIMIT, PLEASE TOP UP'
  end
end
