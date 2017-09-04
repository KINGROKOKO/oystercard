

class OysterCard
  attr_reader :balance, :in_journey

  CARD_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "OVER YOUR £#{CARD_LIMIT} CARD LIMIT" if (amount + @balance) > CARD_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "YOU ARE BELOW YOUR LIMIT, PLEASE TOP UP" if @balance < 1
    @in_journey=true
  end

  def touch_out
    @in_journey=false
  end
end
