require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
  result = HTTParty.get('http://oai.datacite.org/oai?verb=Identify')

	if result['OAI_PMH']['request']['__content__'] == 'http://oai.datacite.org/oai'
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphdatacite', points: points)
end