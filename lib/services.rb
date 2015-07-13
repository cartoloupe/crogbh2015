class Services
  def self.[] key
    categories.find { |category| category.key == key }
  end

  def self.categories
    unless @categories
      @categories = []
      services_directory = Rails.root.join('data', 'services', '*.yml')
      Dir.glob(services_directory).each do |filename|
        /^.*\/(?<category>[a-z-]+)\.yml$/ =~ filename
        data = Psych.load_file(filename)
        @categories << Category.new(category, data)
      end
      @categories = @categories.freeze
    end
    @categories
  end
end
