require_relative 'journey'
require_relative 'station'
class Oystercard

TOP_UP_LIMIT = 90
MINIMUM_BALANCE = 1

attr_accessor :balance
attr_reader :journey_history, :journey

  def initialize
    # reset_station
    @balance = 0
    @journey_history = []
    @journey = nil
  end

  def top_up(amount)
    raise "Top up limit of #{TOP_UP_LIMIT} exceeded" if amount + balance > TOP_UP_LIMIT
    self.balance += amount
  end

  def in_journey?
    !!@journey
  end

  def touch_in!(entry_station)
    raise 'Balance too low, please top up your card' if balance < MINIMUM_BALANCE
    charge_and_close if @journey
    #journey_log.start
    create_new_journey(entry_station)
  end

  def touch_out!(exit_station)
    create_new_journey unless @journey
    @journey.end_journey(exit_station)
    charge_and_close
  end

private
  def create_new_journey(entry_station = nil)
    @journey = Journey.new(entry_station)
  end

  def charge_and_close
    deduct(@journey.fare)
    store_journey
    @journey = nil
  end

  def store_journey
    @journey_history << @journey
  end

  def deduct(amount)
    self.balance -= amount
  end

end
