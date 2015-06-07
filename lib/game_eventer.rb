class GameEventer
  def initialize(game)
    @game = game
    @home = @game.home_lineup
    @guest = @game.guest_lineup
  end

  def goal_event
    if home_attack?
      @game.home_goals = @game.home_goals+1 if goal_for_home?
    else
      @game.guest_goals = @game.guest_goals+1 if goal_for_guest?
    end
  end

  private

  def goal_for_home?
    goal?(@home, @guest)
  end

  def goal_for_guest?
    goal?(@guest, @home)
  end

  def home_attack?
    initiative_for(@home) > initiative_for(@guest)
  end

  def goal?(attacker, defender)
    attacking = attack_for(attacker)
    defending = defense_for(defender)
    (attacking - defending) > (attacking * success)
  end

  def success
    0.90 # je hoeher der success level, desto weniger tore
  end

  def initiative_for(team)
    rand(home_bonus(team)*team.initiative)
  end

  def attack_for(team)
    rand(home_bonus(team)*team.attacking)
  end

  def attack
    rand(home_bonus(@attacking_team)*@attacking_team.attacking)
  end

  def defense_for(team)
    rand(home_bonus(team)*team.defending)
  end

  def defense
    rand(home_bonus(@defending_team)*@defending_team.defending)
  end

  def home_bonus(team)
    team == @game.home ? 1.1 : 1.0
  end
end
