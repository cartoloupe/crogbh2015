require 'street_address'

class Address < ActiveRecord::Base
  EXTRA_WHITESPACE = /\s\s+/

  class << self
    def build_from_text text
      data = StreetAddress::US.parse text

      return nil if data.nil?
      return nil unless data.city.present?

      zip = data.postal_code
      zip << "-#{data.postal_code_ext}" if data.postal_code_ext.present?

      street = "#{data.number} #{data.street} #{data.street_type}"
      street.strip!
      street.gsub! EXTRA_WHITESPACE, ' '

      new(
        street:     street,
        unit:       data.unit,
        unit_label: data.unit_prefix,
        city:       data.city,
        zip:        zip,
        state:      data.state,
      )
    end
  end
end
