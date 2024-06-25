# Puma configuration file

# The `threads` method setting takes two numbers: a minimum and maximum.
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies that the worker count should equal the number of processors in production.
if ENV.fetch("RAILS_ENV", "development") == "production"
  worker_count = ENV.fetch("WEB_CONCURRENCY") { 2 }
  workers worker_count
end

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Preload application for better performance
preload_app!

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)

  # Ensure the Redis connection is reset if using Redis
  if defined?(Redis)
    Redis.current.quit
    Redis.current = Redis.new(url: ENV["REDIS_URL"])
  end
end


# Code to ensure proper AWS S3 setup
before_fork do
  if defined?(ActiveStorage::Service::S3Service)
    ActiveStorage::Service::S3Service.configure_buckets
  end
end
