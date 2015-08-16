class PlayerExchange
  attr_reader :players, :season, :leagues, :start_date

  def initialize(season)
    @season = season
    @leagues = season.leagues
    @start_date = Date.new(season.start_date.year, 7, 1)
  end

  def final_call
    @round = 0
    recurse_negotiation_with(team_brokers(levels_for 1))
  end

  def recurse_negotiation_with(brokers)
    # TODO sicher stellen, dass immer genug Player vorhanden sind
    return unless brokers.any?
    @round = @round + 1
    # puts "@round: #{@round}" + "-"*100
    offers_by brokers
    negotiate! @round
    recurse_negotiation_with(team_brokers(levels_for @round))
  end

  def negotiate!(at_round)
    Player.negotiable.find_each do |player|
      Negotiation.new(player: player, round: at_round).negotiate!
    end
  end

  def offers_by(brokers)
    # puts ".1."*40
    players = Player.contractable
    brokers.each do |broker|
      # puts "offer from #{broker.inspect}" + "-"*100
      # puts ".2."*40
      broker.offers_for(players)
    end
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
      # puts "+1+"*40
      broker = PlayerExchangeBroker.new(team: team, start_date: start_date)
      brokers << broker if broker && broker.need?
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
