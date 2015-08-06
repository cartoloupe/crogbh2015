RSpec::Matchers.define :contain_only do |*proper_classes|
  match do |input|
    input.each do |element|
      expect(proper_classes).to include element.class
    end
  end
end
