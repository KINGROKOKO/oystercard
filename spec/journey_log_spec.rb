require 'journey_log'
require 'journey'
require 'oystercard'

describe JourneyLog do
  it 'CHECKS ENTRY STATION AFTER TOUCH IN' do
    card = OysterCard.new
    card.top_up(5)
    kingscross = Station.new
    card.touch_in(kingscross)
    expect(card.journey_log.entry_station.station_name).to eq 'kingscross'
  end

  it 'CHECKS EXIT STATION AFTER TOUCH OUT' do
    card = OysterCard.new
    card.top_up(5)
    kingscross = Station.new
    card.touch_in(kingscross)
    card.touch_out(kingscross)
    expect(card.journey_log.exit_station).to eq kingscross
  end

  it 'CHECK JOURNEY HISTORY AFTER TOUCH OUT' do
    card = OysterCard.new
    card.top_up(5)
    kingscross = Station.new
    euston = Station.new('euston',1)
    card.touch_in(kingscross)
    card.touch_out(euston)
    expect(card.journey_log.journeys).to eq [{:journey_start=>"kingscross", :journey_end=>"euston"}]
  end
end
