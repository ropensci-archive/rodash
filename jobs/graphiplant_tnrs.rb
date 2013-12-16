require 'httparty'
require 'json'

# Populate the graph with zeros
points = []
(1..10).each do |i|
  points << { x: i, y: rand(0) }
end
last_x = points.last[:x]

SCHEDULER.every '20s', :first_in => 0 do |job|
  # result = HTTParty.get('http://taxosaurus.org/sources/list')
  result = HTTParty.get('http://sharp.iplantcollaborative.org/submit?query=Panthera+tigris%0AEutamias+minimus%0AMagnifera+indica%0AHumbert+humbert')
  out = JSON.parse(result)['message']
  jobid = out.split(' ')[1]

  tt = 'found'

  while tt == 'found'  do
  	result2 = HTTParty.get('http://sharp.iplantcollaborative.org/retrieve/' + jobid)
  	tt = JSON.parse(result2)['status']
  end

  if JSON.parse(result2)['names'][1]['matches'][1]['acceptedName'] == "Mangifera indica"
    out = 50
  else
    out = 0
  end
  
  points.shift
  last_x += 1
  points << { x: last_x, y: out }
  
  send_event('graphiplant_tnrs', points: points)  
end

