class ValidValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    unless value.present? && value.valid?
      record.errors[attribute] << (options[:message] || 'must not be nil')
    end
  end
end
