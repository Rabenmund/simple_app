class PlayerNeed
  attr_reader :need, :avg
  def initialize(base, size)
    @need = base-size
  end
end
