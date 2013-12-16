require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
  result = HTTParty.get('http://services.tropicos.org/Name/25509881?apikey=f3e499d4-1519-42c9-afd1-685a16882f5a&format=json')
  
	if result['NameId'] == 25509881
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphtropicos', points: points)
end