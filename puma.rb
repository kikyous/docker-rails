workers ENV.fetch("PUMA_WORKERS") { 0 }.to_i
threads_count = ENV.fetch("PUMA_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count
preload_app!
environment ENV.fetch("RAILS_ENV") { "development" }

pidfile '/tmp/puma.pid'
bind "unix:///tmp/run.sock"

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end
