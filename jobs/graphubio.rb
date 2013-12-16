require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
  result = HTTParty.get('http://www.ubio.org/webservices/service.php?function=namebank_object&namebankID=2483153&keyCode=b052625da5f330e334471f8efe725c07bf4630a6')
  
	if result['results']['namebankID'] == "2483153"
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphubio', points: points)
end