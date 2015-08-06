class UserTypeExcluding
  def initialize *inputs
    @non_matching_types = inputs.map { |input| UserTypes.type_for input }.freeze
  end

  def matches? request
    ! non_matching_types.include?(CurrentUser.type)
  end

  private

  attr_reader :non_matching_types
end
