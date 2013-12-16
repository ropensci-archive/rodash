require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|

  result = HTTParty.get("http://api.impactstory.org/v1?key=chamberlain-i46lg5")

	if result["message"] == "Congratulations! You have found the ImpactStory API."
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphimpactstory', points: points)
end