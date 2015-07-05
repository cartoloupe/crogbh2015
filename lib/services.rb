require 'ice_nine'

class Services
  def self.[] category
    services[category]
  end

  def self.services
    unless @services
      @services = {}
      services_directory = Rails.root.join('data', 'services', '*.yml')
      Dir.glob(services_directory).each do |filename|
        /^.*\/(?<category>[a-z-]+)\.yml$/ =~ filename
        @services[category.to_sym] = load_category(filename)
      end
      @services = IceNine.deep_freeze @services
    end
    @services
  end
  private_class_method :services

  def self.load_category filename
    category = Psych.load_file(filename)
    category.each do |service|
      service.symbolize_keys!
      service[:phone]            = Array service[:phone]
      service[:mailing_address]  = Array service[:mailing_address]
      service[:physical_address] = Array service[:physical_address]
      service[:description]      = markdown.render service[:description].to_s
    end
    category
  end
  private_class_method :load_category

  def self.markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end
  private_class_method :markdown
end
