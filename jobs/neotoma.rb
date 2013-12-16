require 'httparty'

SCHEDULER.every '60s', :first_in => 0 do |job|
  result = HTTParty.get("http://api.neotomadb.org/v1/data/sites/1")

	if result['data'][0]['LongitudeWest'] == -75.25
			out = "BOOM! It's up"
			# out = 100
		else
			out = "Sad. It's down"
			# out = 0
		end
  
  send_event('neotoma', { text: out })
end