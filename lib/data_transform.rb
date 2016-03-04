module DataTransform
  def is_record?(line)
    line =~ /:/
  end

  def is_start?(line)
    line =~ /^Organization:/i
  end

  def parse_record(line)
    field, value = line.split(":", 2) # only split on first :
    [field.downcase, value]
  end
end
