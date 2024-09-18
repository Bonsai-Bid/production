# # config/initializers/secure_headers.rb
# SecureHeaders::Configuration.default do |config|
#   # Protect against clickjacking attacks
#   config.x_frame_options = "DENY"

#   # Prevent the browser from interpreting files as a different MIME type
#   config.x_content_type_options = "nosniff"

#   # Enable XSS protection in browsers
#   config.x_xss_protection = "1; mode=block"

#   # Content Security Policy (CSP) configuration
#   config.csp = {
#     default_src: %w('self'),          # Allow resources only from the same origin
#     script_src: %w('self'),           # Allow scripts only from the same origin
#     style_src: %w('self'),            # Allow styles only from the same origin
#     img_src: %w('self' data: https:), # Allow images from the same origin and secure sources
#     object_src: %w('none'),           # Disallow embedding of objects
#     upgrade_insecure_requests: true   # Automatically upgrade insecure requests to HTTPS
#   }

#   # Referrer policy
#   config.referrer_policy = "strict-origin-when-cross-origin"
# end
