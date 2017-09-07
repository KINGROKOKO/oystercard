require 'Journey'
require 'oystercard'

# describe Journey do
# it 'CHECKS ENTRY STATION AFTER TOUCH IN' do
#   card = OysterCard.new
#   card.top_up(5)
#   kingscross = double
#   card.touch_in(kingscross)
#   expect(subject.journey).to eq kingscross
# end
# end

# it 'CHECK JOURNEY HISTORY' do
#   expect(subject.journey.journey_history.empty?).to eq true
# end

# it 'CHECKS TOUCH IN AND OUT STORES ONE JOURNEY' do
#   subject.top_up(5)
#   kingscross = Station.new('kingscross')
#   euston = Station.new('euston')
#   subject.touch_in(kingscross.station_name)
#   subject.touch_out(euston.station_name)
#   expect(subject.journey.journey_history).to eq [{ journey_start: kingscross.station_name, journey_end: euston.station_name }]
# end

# it 'CHECK JOURNEY HISTORY' do
#   kingscross = Station.new('kingscross')
#   euston = Station.new('euston')
#   subject.top_up(5)
#   subject.touch_in(kingscross.station_name)
#   subject.touch_out(euston.station_name)
#   expect(subject.journey.journey_history).to eq [{ journey_start: kingscross.station_name, journey_end: euston.station_name }]
# end
