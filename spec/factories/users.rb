FactoryBot.define do
  factory :user do
    email { generate_safe_value { Faker::Internet.email } }
    password { '!password' }
    password_confirmation { '!password' }
    street { generate_safe_value { Faker::Address.street_address } }
    city { generate_safe_value { Faker::Address.city } }
    state { generate_safe_value { Faker::Address.state_abbr } }
    zip { generate_safe_value { Faker::Address.zip_code } }
    first_name { generate_safe_value { Faker::Name.first_name } }
    last_name { generate_safe_value { Faker::Name.last_name } }
    phone { generate_safe_value { Faker::PhoneNumber.phone_number } }
    time_zone { ["Pacific Time (US & Canada)", "Mountain Time (US & Canada)", "Central Time (US & Canada)", "Eastern Time (US & Canada)"].sample }
  end
end

# Helper method to validate generated values against SQL patterns
def generate_safe_value
  loop do
    value = yield
    return value if valid_value?(value)
  end
end

def valid_value?(value) #This is in the user model
  patterns = [
    /<script.*?>.*?<\/script>/i,        # XSS detection for script tags
    /--|#/,                             # SQL comment indicators
    /;/,                                # Semicolons for query termination
    /\b(SELECT|UNION|INSERT|UPDATE|DELETE|DROP|ALTER)\b/i, # SQL keywords
    /\b(OR|AND)\b\s+['"][^'"]+['"]/i,   # Specific SQL injection sequences like ' OR '
    /\b(=|LIKE|IS)\b/,                  # Equality and comparison operators
    /[\(\)]/,                           # Parentheses for SQL functions
    /\/\*|\*\//                         # Inline comments or concatenation
  ]

  # Check the value against each pattern
  patterns.none? { |pattern| pattern.match?(value) }
end
