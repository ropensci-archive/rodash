require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
  # result = HTTParty.get('http://ebird.org/ws1.1/data/obs/geo_spp/recent?lng=-70.51&lat=42.4&sci=branta%20canadensis&fmt=json')
  result = HTTParty.get('http://ebird.org/ws1.1/data/obs/geo_spp/recent?lng=-76.51&lat=45.46&sci=branta%20canadensis&fmt=json')
  						 
	if result[0]['comName'] == "Canada Goose"
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphebird', points: points)
end