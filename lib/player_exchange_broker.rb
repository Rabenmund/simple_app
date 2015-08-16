class PlayerExchangeBroker
  attr_reader :team, :reputation, :start_date

  def initialize(start_date: start_date, team: team)
    @start_date = start_date
    @team = team
    @reputation = team.reputation
    @need = team.player_need
    @need_keepers = team.needs(:keepers)
    @need_defenders = team.needs(:defenders)
    @need_midfielders = team.needs(:midfielders)
    @need_attackers = team.needs(:attackers)
  end

  def need?
    @need > 0
  end

  def offers_for(players)
    return false unless players.any?
    return false unless @need
    # puts "-1-"*40
    @keepers = players.keepers
    @defenders = players.defenders
    @midfielders = players.midfielders
    @attackers = players.attackers
    # puts "-2-"*40
    offer!
  end

  def offer!
    team.player_need.times do
      # puts "-3-"*40
      put_best_offer_for needed_type
    end
  end

  def needed_type
    formation_type || any_type
  end

  def formation_type
    return :keepers if @need_keepers > 0
    return :defenders if @need_defenders > 0
    return :midfielders if @need_midfielders > 0
    return :attackers if @need_attackers > 0
    return false
  end

  def any_type
    pos = rand 3
    %w[defenders midfielders attackers][pos]
  end

  def put_best_offer_for(type)
    return false unless type
    offer_for_best_player_in players_of_type(type)
    reduce_1_from_need_of(type)
  end

  def players_of_type(type)
    eval("@#{type}").without_offer_by(team)
  end

  def reduce_1_from_need_of(type)
    eval("@need_#{type} -= 1")
  end

  def offer_for_best_player_in(players)
    offer_for best_player_in(players)
  end

  def offer_for(player)
    return false unless player
    puts "#{team.abbreviation} offers for #{player.name}"\
        " with reputation #{reputation}"
    Offer.create(
      team: team,
      player: player,
      reputation: reputation,
      start_date: start_date,
      end_date:  random_end_date
    )
  end

  def best_player_in(players)
    # assuming players is ordered by best player first
    # puts "---> recurse_best_player: #{players.first.better_offers(reputation)}"
    return false unless players
    return players.first if players.size == 1
    return players.first unless players.first.better_offers(reputation) >= 3
    # recurse
    best_player_in(players - [players.first])
  end

  def random_end_date
    years = rand(5) + 1
    Date.new((start_date + years.years).year, 06, 30)
  end
end
