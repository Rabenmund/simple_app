class ShootOutEventer
  def initialize(game)
    @game = game
    @home = HomeTeam.new(game.home)
    @guest = GuestTeam.new(game.guest)
  end

  def perform!
    @game.update_attributes(home_goals: (@game.home_goals || 0) +1) if goal_event_with
    @game.update_attributes(guest_goals: (@game.guest_goals || 0) +1) if goal_event_with
    @game.update_attributes(shots: @game.shots+1)
    return @game
  end

  private

  def goal_event_with(expectation=70)
    Random.new.rand(1..100) <= expectation
  end
end
