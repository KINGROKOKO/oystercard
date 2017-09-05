

class OysterCard
  attr_reader :balance, :entry_station, :journey, :journey_history

  CARD_LIMIT = 90

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "OVER YOUR £#{CARD_LIMIT} CARD LIMIT" if (amount + @balance) > CARD_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'BELOW LIMIT, TOP UP' if @balance < 1
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    @balance -= 1
    @journey = {:journey_start => @entry_station, :journey_end => @exit_station}
    @journey_history << @journey
    @entry_station = nil
  end

  def in_journey?
    return false if @entry_station.nil?
    true
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
