require "active_support/core_ext/integer/time"

Rails.application.configure do

  config.enable_reloading = false


  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  config.action_mailer.default_url_options = { host: 'your-production-host.com' }

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?


  config.assets.compile = false

  config.active_storage.service = :amazon

  config.force_ssl = true

  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]


  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end


  config.action_mailer.perform_caching = false


  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

end
