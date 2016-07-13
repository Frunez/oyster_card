require_relative 'journey'

class JourneyLog

  def initialize(journey_class)
    @journey_class = journey_class
    @journey_history = []
  end

  def start(entry_station)
    new_journey = @journey_class.new(entry_station)
  end

  private

  def current_journey
  end

end
