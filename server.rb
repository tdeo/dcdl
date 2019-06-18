require 'sinatra'
require 'json'

require './dcdl'

post '/solve' do
  request.body.rewind
  data = JSON.parse(request.body.read)
  solver = Dcdl.new(data['target'])
  return JSON.dump(solver.solve(data['numbers']))
end
