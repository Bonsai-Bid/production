# app/models/concerns/enum_nil_handler.rb
module EnumNilHandler
  extend ActiveSupport::Concern

  included do
    before_validation :convert_empty_strings_to_nil
  end

  private

  def convert_empty_strings_to_nil
    self.class.defined_enums.keys.each do |enum_field|
      self[enum_field] = nil if self[enum_field].blank?
    end
  end
end
