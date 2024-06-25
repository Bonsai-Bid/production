# config/initializers/aws.rb
region = Rails.application.credentials.dig(:aws, :region)
access_key_id = Rails.application.credentials.dig(:aws, :access_key_id)
secret_access_key = Rails.application.credentials.dig(:aws, :secret_access_key)

Rails.logger.info "AWS Region: #{region}"
Rails.logger.info "AWS Access Key ID: #{access_key_id}"

Aws.config.update({
  region: region,
  credentials: Aws::Credentials.new(
    access_key_id,
    secret_access_key
  )
})
