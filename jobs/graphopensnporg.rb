require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job| 
  result = HTTParty.get("http://opensnp.org/snps/json/rs9939609/1.json")

	if result['snp']['name'] == "rs9939609"
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphopensnporg', points: points)
end