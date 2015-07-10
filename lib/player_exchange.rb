class PlayerExchange
  attr_reader :players, :season, :leagues

  def initialize(season)
    @season = season
    @leagues = season.leagues
  end

  def final_call
    @round = 0
    negotiation_with(team_brokers(levels_for 1))
  end

  def negotiation_with(members)
    return unless members.any?
    @round = @round + 1
    offers_by members
    negotiate! @round
    negotiation_with(team_brokers(levels_for @round))
  end

  def negotiate!(at_round)
    players.joins(:offers).uniq.find_each do |player|
      player.negotiate! at_round
    end
  end

  def offers_by(brokers)
    brokers.each do |broker|
      offers = broker.offers_for(players)
    end
  end

  def players
    Player.contractable
  end

  def team_brokers(levels)
    if levels.any?
      brokers = Array.new
      season.leagues.by_levels(levels).each do |league|
        brokers += brokers_for(league.teams)
      end
      brokers
    else
      brokers_for(season.teams.all)
    end
  end

  def brokers_for(teams)
    brokers = Array.new
    teams.each do |team|
      broker = team.broker
      brokers << broker if broker
    end
    brokers
  end

  def levels_for(round)
    LEVELS[round] || []
  end

  LEVELS = {
    1 => [1],
    2 => [1],
    3 => [1],
    4 => [1,2],
    5 => [1,2],
    6 => [1,2],
    7 => [1,2,3],
    8 => [1,2,3],
    9 => [1,2,3]
  }
end
  # attr_reader :teams

  # def initialize(season)
  #   @teams = TransferTeams.new
  # end

  # def perform
  #   # besten verfügbaren spieler mit rolle find
  #   team = teams.first
  #   player = Player(team.need).first
  #   if Contract.negotiated?(player, team)
  #     teams.reorder_first
  #   end
  # end

# end

# class TransferTeams
  # attr_reader :teams
  # def initialize
  #   @teams = Hash.new
  #   # iterate through leagues -> teams - fill list
  # end

  # def need
  #   first.need
  # end

  # def reorder_first
  #   team = first
  #   remove_first
  #   arrange(team)
  # end

  # private

  # def first
  #   teams[teams.keys.first]
  # end

  # def remove_first
  #   teams.delete team.keys.first
  # end

  # def arrange(team)
  #   key = team.transfer_key
  #   teams.merge!({key => team.id}) if key
  # end

# end
