class PlanGame
  attr_reader :start

  def initialize(home_id:, guest_id:, start:)
    @home_id = home_id
    @guest_id = guest_id
    @start = start
  end

  def attributes
    { home_id: home_id, guest_id: guest_id }
  end

  private

  attr_reader :home_id, :guest_id

end
