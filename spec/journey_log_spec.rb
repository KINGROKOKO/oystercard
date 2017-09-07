require 'journey_log'
require 'journey'
require 'oystercard'

describe JourneyLog do
  it 'CHECKS ENTRY STATION AFTER TOUCH IN' do
    card = OysterCard.new
    card.top_up(5)
    kingscross = double
    card.touch_in(kingscross)
    expect(card.journey_log.entry_station).to eq kingscross
  end

  it 'CHECKS EXIT STATION AFTER TOUCH OUT' do
    card = OysterCard.new
    card.top_up(5)
    kingscross = double
    card.touch_in(kingscross)
    card.touch_out(kingscross)
    expect(card.journey_log.exit_station).to eq kingscross
  end

end
