require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
  result = HTTParty.get('http://resolver.globalnames.org/name_resolvers.json?names=Plantago+major&data_source_ids=1')
  
	if result['data'][0]['supplied_name_string'] == "Plantago major"
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('grapheol_gnr', points: points)
end