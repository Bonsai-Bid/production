# namespace :active_storage do
#   desc "Update service_name for all blobs to 'local' in development"
#   task update_service_name: :environment do
#     if Rails.env.development?
#       ActiveStorage::Blob.update_all(service_name: "local")
#       puts "Updated all blobs to use 'local' service"
#     else
#       puts "This task should only be run in the development environment"
#     end
#   end
# end
