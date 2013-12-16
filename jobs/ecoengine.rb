require 'httparty'

SCHEDULER.every '60s', :first_in => 0 do |job|
  result = HTTParty.get("http://ecoengine.berkeley.edu/api/?format=json")

	if result['query']['page'] == 1
			out = "BOOM! It's up"
			# out = 100
		else
			out = "Sad. It's down"
			# out = 0
		end
  
  send_event('altmetric', { text: out })
end