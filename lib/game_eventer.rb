class GameEventer
  def initialize(game)
    @game = game
    @home = HomeTeam.new(game.home)
    @guest = GuestTeam.new(game.guest)
  end

  def perform!
    @game.update_attributes(home_goals: (@game.home_goals || 0) +1) if goal_event_with @home.goal_expectation
    @game.update_attributes(guest_goals: (@game.guest_goals || 0) +1) if goal_event_with @guest.goal_expectation
    return @game
  end

  private

  def goal_event_with(quotient)
    Random.new.rand(1..(90 / quotient).to_i) == 1
  end
end
