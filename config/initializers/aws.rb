# config/initializers/aws.rb
Rails.logger.info "AWS Region: #{Rails.application.credentials.dig(:aws, :region)}"
Rails.logger.info "AWS Access Key ID: #{Rails.application.credentials.dig(:aws, :access_key_id)}"

Aws.config.update({
  region: Rails.application.credentials.dig(:aws, :region),
  credentials: Aws::Credentials.new(
    Rails.application.credentials.dig(:aws, :access_key_id),
    Rails.application.credentials.dig(:aws, :secret_access_key)
  )
})
