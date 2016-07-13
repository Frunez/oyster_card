require_relative 'station'

class Journey

MINIMUM_BALANCE = 1
PENALTY_FARE = 6

attr_accessor :entry_station, :exit_station

  def  initialize(entry_station: nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def end_journey(exit_station)
    self.exit_station = exit_station
  end

  def in_progress?
    !!@entry_station
  end

  def fare
    ((entry_station == nil) || (exit_station == nil)) ? PENALTY_FARE : MINIMUM_BALANCE
  end
end
