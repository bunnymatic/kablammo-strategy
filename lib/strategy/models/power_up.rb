module Strategy::Model
  class PowerUp
    include Base
    include Target

    attr_accessor :name, :duration, :type, :abilities

    def initialize(parent, args)
      super
      @parent = parent
    end

    def to_s
      "PowerUp[#{x}, #{y}, #{name}, #{duration}]"
    end
  end
end
