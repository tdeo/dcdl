require 'json'

require 'sinatra'
require 'sinatra/cross_origin'

require './dcdl'

class MyApp < Sinatra::Base
  set :bind, '0.0.0.0'

  configure do
    enable :cross_origin
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  post '/solve' do
    request.body.rewind
    data = JSON.parse(request.body.read)
    solver = Dcdl.new(data['target'])
    return JSON.dump(solver.solve(data['numbers']))
  end


  options '*' do
    response.headers['Allow'] = 'GET, PUT, POST, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token'
    response.headers['Access-Control-Allow-Origin'] = '*'
    200
  end
end
