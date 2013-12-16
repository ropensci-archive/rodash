require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|

  result = HTTParty.get("http://alm.plos.org/articles/10.1371/journal.pbio.0000012.json?api_key=WQcDSXml2VSWx3P")['article']['doi']

	if result == "10.1371/journal.pbio.0000012"
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphplosalm', points: points)
end