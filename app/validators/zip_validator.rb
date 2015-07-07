class ZipValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    unless value =~ /^(?:\d{5}|\d{9})?$/
      record.errors[attribute] << (options[:message] || 'is not a zip code')
    end
  end
end
