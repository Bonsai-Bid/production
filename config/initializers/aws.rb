# config/initializers/aws.rb
# region = ENV['AWS_REGION'] || Rails.application.credentials.dig(:aws, :region)
# access_key_id = ENV['AWS_ACCESS_KEY_ID'] || Rails.application.credentials.dig(:aws, :access_key_id)
# secret_access_key = ENV['AWS_SECRET_ACCESS_KEY'] || Rails.application.credentials.dig(:aws, :secret_access_key)


# Aws.config.update({
#   region: region,
#   credentials: Aws::Credentials.new(
#     access_key_id,
#     secret_access_key
#   )
# })

Aws.config.update({
  region: ENV['AWS_REGION'],
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
})

# s3 = Aws::S3::Client.new
