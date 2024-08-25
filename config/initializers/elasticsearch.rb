# config/initializers/elasticsearch.rb

Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: Rails.application.config_for(:elasticsearch)["host"],
  transport_options: Rails.application.config_for(:elasticsearch)["transport_options"]
)
