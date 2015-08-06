class UserTypeIncluding
  def initialize *inputs
    @matching_types = inputs.map { |input| UserTypes.type_for input }.freeze
  end

  def matches? request
    matching_types.include? CurrentUser.type
  end

  private

  attr_reader :matching_types
end
