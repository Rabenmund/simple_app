class PlayerExchangeBroker
  attr_reader :team, :reputation, :start_date
  attr_accessor :players, :keepers, :defenders, :midfielders, :attackers

  def initialize(start_date: start_date, team: team, keepers: keepers, defenders: defenders, midfielders: midfielders, attackers: attackers)
    @start_date = start_date
    @team = team
    @reputation = team.reputation
    @keepers = keepers
    @midfielders = midfielders
    @defenders = defenders
    @attackers = attackers
    @players = Player.contractable
  end

  def offers_for(contractable_players)
    players = contractable_players
    offer!
  end

  def offer!
    %w[keepers defenders midfielders attackers].each do |type|
      send(type).times do
        put_best_offer_for type
      end
    end
  end

  def put_best_offer_for(type)
    matching_players = players.send(type).without_offer_by(team)
    player = new_best_player(matching_players)
    if player
      Offer.create(
        team: team,
        player: player,
        reputation: reputation,
        start_date: start_date,
        end_date:  random_end_date
      )
      need = send(type)
      send(type.to_s+"=", (need - 1))
    else
      raise NotEnoughPlayersError.new(type)
    end
  end

  def new_best_player(matching_players)
    if matching_players.any?
      best_player = matching_players.first
      if best_player.better_offers(reputation) >= 3 && matching_players.size > 1
        new_best_player(matching_players - [best_player])
      else
        best_player
      end
    end
  end

  private

  def random_end_date
    years = rand(5) + 1
    Date.new((start_date + years.years).year, 06, 30)
  end
end
