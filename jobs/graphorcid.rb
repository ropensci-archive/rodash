require 'httparty'
require 'crack'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
	
	class Foo
	  include HTTParty
	  headers 'Accept' => 'application/orcid+xml'
	end

	result = HTTParty.get('http://pub.orcid.org/search/orcid-bio/?q=family-name:Sanchez&start=1&rows=1')
	res2 = Crack::XML.parse(result)
	  
	if res2['orcid_message']['xmlns'] == "http://www.orcid.org/ns/orcid"
		out = 50
	else
		out = 0
	end
  
  	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphorcid', points: points)
end