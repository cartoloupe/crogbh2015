RSpec::Matchers.define :match_hash do |hash|
  match do |object|
    hash.each do |key, value|
      expect(value).to eq object.send(key)
    end
  end
end

