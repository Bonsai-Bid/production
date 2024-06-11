module ApplicationHelper

  def format_currency(value)
    if value.is_a?(Numeric) && value > 0
      number_to_currency(value, unit: '', precision: 2)
    else
      "No bids yet"
    end
  end


end
