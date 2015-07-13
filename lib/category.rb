class Category
  attr_reader :key, :services

  def initialize key, services
    self.key      = key
    self.services = services
  end

  def name
    @name ||= key
      .to_s
      .split('-')
      .map(&:capitalize)
      .join(' ')
      .freeze
  end

  private

  def key= value
    @key = value.to_sym
  end

  def services= value
    @services = value.map do |data|
      Service.new data
    end.freeze
  end
end
