require 'httparty'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
  result = HTTParty.get("http://www.biodiversitylibrary.org/api2/httpquery.ashx?op=GetPageMetadata&apikey=ea5bbfda-e6ad-4fce-b288-70fa9410a9b3&pageid=1328690")

	if result['Response']['Status'] == "ok"
		out = 50
	else
		out = 0
	end

	points.shift
	last_x += 1
	points << { x: last_x, y: out }
	
	send_event('graphbhl', points: points)
end