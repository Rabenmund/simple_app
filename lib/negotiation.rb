class Negotiation

  def initialize(player: player)
    @offers = player.offers
    @human = player.human
  end

  def negotiate!
    deal_with best_offer
    decline_open_offers
  end

  def deal_with(offer)
    return unless offer
    offer.accept!
    Contract.create(
      organization: offer.team.organization,
      human: human,
      from: offer.start_date,
      to: offer.end_date
    )
  end

  def decline_open_offers
    offers.open.map {|offer| offer.decline! }
  end

  private

  attr_reader :offers, :human, :start_date, :end_date

  def best_offer
    # TODO not ready
    # wenn keeper und offered team hat schon besseren keeper UND Mannschaft ist Nicht 1 Liga höher als ich UND wenn nicht 10+ Runde -> offer ablehnen
    # wenn keeper und offered team hat schon 2 bessere keeper UND Mannschaft ist Nicht 2 Liga höher als ich UND wenn nicht 10+ Runde -> offer ablehnen
    return unless offers.any?
    open_offers_count = offers.open.count
    return unless open_offers_count > 0
    pos = rand(open_offers_count)
    offers.open[pos]
  end

end
