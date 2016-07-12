class Oystercard

TOP_UP_LIMIT = 90

attr_accessor :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Top up limit of #{TOP_UP_LIMIT} exceeded" if amount + balance > TOP_UP_LIMIT
    self.balance += amount
  end

  def deduct(amount)
    self.balance -= amount
  end

end
