class Service
  attr_reader :title, :description, :mailing_address, :physical_address, :phone, :email, :website

  def initialize data
    data.symbolize_keys!
    %w{title description mailing_address physical_address phone email website}.each do |attribute|
      send "#{attribute}=", data[attribute.to_sym]
    end
  end

  private

  def title= value
    @title = value.freeze
  end

  def description= value
    @description = self.class.send(:markdown).render(value.to_s).freeze
  end

  def mailing_address= value
    @mailing_address = frozen_array value
  end

  def physical_address= value
    @physical_address = frozen_array value
  end

  def phone= value
    @phone = frozen_array value
  end

  def website= value
    @website = value.freeze
  end

  def email= value
    @email = value.freeze
  end

  def frozen_array input
    IceNine.deep_freeze Array(input)
  end

  def self.markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end
  private_class_method :markdown
end
