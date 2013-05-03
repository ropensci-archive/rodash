require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '60s', :first_in => 0 do |job|
  result = HTTParty.get("https://www.usanpn.org/npn_portal/observations/getAllObservationsForSpecies.json?species_id[0]=52&start_date=2011-01-01&end_date=2011-02-01")

	if result['station_list'][0]['station_id'] == "4881"
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphnpn', points: points)
end