module ApplicationHelper

  def format_currency(value)
    if value.is_a?(Numeric) && value > 0
      number_to_currency(value, unit: '', precision: 2)
    else
      "No Bids Yet"
    end
  end

  def format_enum(enum_value)
    def format_enum(enum_value)
      # Convert the enum value to a string
      formatted_value = enum_value.to_s
  
      # Check if the value is 'us' and capitalize both letters
      if formatted_value == 'us'
        formatted_value.upcase
      else
        # Default formatting: humanize and titleize
        formatted_value.humanize.titleize
      end
    end
  end


end
