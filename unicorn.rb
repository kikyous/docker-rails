pid '/tmp/unicorn.pid'
listen "/tmp/run.sock", backlog: 64
worker_processes ENV['UNICORN_WORKERS'] || 1
timeout 30
