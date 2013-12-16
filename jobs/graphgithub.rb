require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
	result = HTTParty.get('https://api.github.com/repos/ropensci/rmendeley/forks', :headers => {"User-Agent" => "Httparty"})
  
	if result[0]['name'] == "RMendeley"
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphgithub', points: points)
end