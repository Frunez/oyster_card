require './lib/oystercard'

enter_station = Station.new(name: "Charring Cross", zone: 1)
exit_station = Station.new(name: "Banana Hill", zone: 5)

card = Oystercard.new

card.top_up(15)


 card.touch_in!(enter_station)

 card.touch_out!(exit_station)
puts "\n============"
 card.journey_history
puts "\n============"
 card.touch_in!(enter_station)
 print card.in_journey?

 card.touch_out!(exit_station)
puts "\n============"
 card.journey_history
puts "\n============"
 print card.in_journey?
