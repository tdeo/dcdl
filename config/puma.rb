workers 2
threads_count = 1
threads threads_count, threads_count

rackup      DefaultRackup
port        ENV['PORT']     || 4567
environment ENV['RACK_ENV'] || 'development'
quiet false
