def randomize_case input
  input.chars.map { |char| [char.upcase, char.downcase].sample }.join ''
end
