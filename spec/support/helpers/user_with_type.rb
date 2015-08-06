def user_with_type input
  detail_class = UserTypes.detail_class_for(input)
  return nil if detail_class.nil?
  create :user, details: (create detail_class)
end
