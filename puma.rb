workers ENV['PUMA_WORKERS'] || 0
threads 1, 6
preload_app!
environment 'production'
pidfile '/tmp/puma.pid'
bind "unix:///tmp/puma.sock"

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end
