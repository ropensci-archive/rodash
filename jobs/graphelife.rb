require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
  result = HTTParty.get('https://fluiddb.fluidinfo.com/values?query=elifesciences.org/api_v1/article/doi=%2210.7554/eLife.00013%22&tag=*')
  
	if result['results']['id']['eb275979-d99d-4e44-a84f-15ce912ca888']['fluiddb/about']['username'] == "fluiddb"
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphelife', points: points)
end