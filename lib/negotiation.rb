class Negotiation

  def initialize(player: player, round: 0)
    @offers = player.offers
    @human = player.human
    @round = round
    @start_date = start_date
    @end_date = end_date
  end

  def negotiate!
    deal_with best_team
    decline_open_offers
  end

  def deal_with(team)
    accept_offer_with team
    Contract.create(
      organization: team.organization,
      human: human,
      from: Season.current.start_date,
      to: Season.current.end_date
    )
  end

  def decline_open_offers(at_round=0)
    offers.open.map {|offer| offer.decline!(at_round)}
  end

  private

  attr_reader :offers, :human, :round, :start_date, :end_date

  def accept_offer_with(team)
    offers.open.find_by(team_id: team.id).try {|offer| offer.accept!(round)}
  end

  def best_team
    # TODO not ready
    # wenn keeper und offered team hat schon besseren keeper UND Mannschaft ist Nicht 1 Liga höher als ich UND wenn nicht 10+ Runde -> offer ablehnen
    # wenn keeper und offered team hat schon 2 bessere keeper UND Mannschaft ist Nicht 2 Liga höher als ich UND wenn nicht 10+ Runde -> offer ablehnenA
    open_offers_count = offers.open.count
    return unless open_offers_count < 1
    pos = rand(offers_open_count)
    offers.open.order(reputation: :desc)[pos].team
  end

end
