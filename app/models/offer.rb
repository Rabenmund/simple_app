class Offer < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  validates :player, presence: true
  validates :team, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true


  scope :open, -> { where(negotiated: false) }

  def accept!(round=0)
    update_attributes(negotiated: true, accepted: true, negotiation_round: round)
  end

  def decline!(round=0)
    update_attributes(negotiated: true, accepted: false, negotiation_round: round)
  end
end
