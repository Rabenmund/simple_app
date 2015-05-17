class GameEventer
  def initialize(game)
    @game = game
    if initiative_for(@game.home) > initiative_for(@game.guest)
      @home_attack = true
      @attacking_team = @game.home
      @defending_team = @game.guest
    else
      @guest_attack = true
      @attacking_team = @game.guest
      @defending_team = @game.home
    end
  end

  def perform!
    goal_event?
  end

  private

  def goal_event?
    if (attack - defense) > (attack * success)
      @game.update_attributes(home_goals: @game.home_goals+1) if @home_attack
      @game.update_attributes(guest_goals: @game.guest_goals+1) if @guest_attack
      true
    else
      false
    end
  end

  def success
    0.90 # je hoeher der success level, desto weniger tore
  end

  def initiative_for(team)
    rand(home_bonus(team)*team.initiative)
  end

  def attack
    @attack ||= rand(home_bonus(@attacking_team)*@attacking_team.attacking)
  end

  def defense
    @defense ||= rand(home_bonus(@defending_team)*@defending_team.defending)
  end

  def home_bonus(team)
    team == @game.home ? 1.1 : 1.0
  end
end
