require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
  result = HTTParty.get("http://www.itis.gov/ITISWebService/services/ITISService/getITISTermsFromScientificName?srchKey=helianthus%20annuus")

	if result['getITISTermsFromScientificNameResponse']['return']['itisTerms'][0]['tsn'] == '36616'
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphitis', points: points)
end