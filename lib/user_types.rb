module UserTypes
  class InvalidTypeSymbol < StandardError
    def initialize symbol; @symbol = symbol; end
    def message; "Invalid user type symbol: #{@symbol.inspect}"; end
  end

  class InvalidDetailClass < StandardError
    def initialize detail_class; @detail_class = detail_class; end
    def message; "Invalid detail class: #{detail_class}"; end
  end

  class InvalidInput < StandardError
    def initialize input; @input = input; end
    def message; "Invalid input: #{@input.inspect}"; end
  end

  class << self
    include Enumerable

    private

    USER_TYPES = IceNine.deep_freeze(
      none:     nil,
      end_user: EndUserDetail,
      admin:    AdminUserDetail,
    )

    public

    def each &block
      iterate USER_TYPES, block
    end

    def each_except *excepted_types, &block
      types = USER_TYPES.reject { |type, _| excepted_types.include? type }
      iterate types, block
    end

    def [] input
      case input
      when nil   then :none
      when :none then nil
      when Symbol
        each do |type, detail_class|
          return detail_class if type == input
        end
        raise InvalidTypeSymbol.new input
      when Class
        each do |type, detail_class|
          return type if detail_class == input
        end
        raise InvalidDetailClass.new input
      when User
        self[input.details.class]
      else
        raise InvalidInput.new input
      end
    end

    def types
      USER_TYPES.keys
    end

    def detail_classes
      USER_TYPES.map { |_, detail_class| detail_class }
    end

    def count
      USER_TYPES.count
    end

    def detail_class_for input
      # double self normalizes and validates value
      input.is_a?(Symbol) ? self[input] : self[self[input]]
    end

    def type_for input
      # double self normalizes and validates value
      input.is_a?(Symbol) ? self[self[input]] : self[input]
    end

    def match? input_a, input_b
      type_for(input_a) == type_for(input_b)
    end

    private

    def iterate types, block
      types.each do |key, detail_class|
        block.call key, detail_class
      end
    end
  end
end
