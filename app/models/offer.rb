class Offer < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  validates :player_id, presence: true
  validates :team_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :open, -> { where(negotiated: false) }

  def accept!
    update_attributes(negotiated: true, accepted: true)
  end
end
