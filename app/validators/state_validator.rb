class StateValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    unless value =~ /^(?:[A-Z]{2})?$/
      record.errors[attribute] << (options[:message] || 'is not a valid state')
    end
  end
end
