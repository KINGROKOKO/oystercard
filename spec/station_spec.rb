require 'station'

describe Station do
  it 'CHECKS STATION NAME' do
    Station.new
    expect(subject.station_name).to eq 'kingscross'
  end

  it 'CHECKS STATION ZONE' do
    Station.new
    expect(subject.zone).to eq 1
  end
end
