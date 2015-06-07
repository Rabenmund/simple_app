class UpdatePlayerStrength
  def self.after_matchday(matchday)
    matchday.games.each do |game|
      Player::STRENGTH.keys.each do |act|
        game.winner_lineup.send(Player::STRENGTH[act]).each do |actor|
          player = actor.actorable
          add_strength(1, player, act)
          add_strength(rand(3), player, act)
          player.save
        end
        game.loser_lineup.send(Player::STRENGTH[act]).each do |actor|
          player = actor.actorable
          add_strength(rand(3), player, act)
          player.save
        end
      end
    end
  end

  def self.after_season(season)
    # punkte
    # alter
    # liga schnitt
    # pokal gegner stärke ?
  end

  private

  def self.add_strength(add, player, act)
    strength = player.send(act)
    eval "player.#{act} = #{strength} + #{add}"
  end

end

