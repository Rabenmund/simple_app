class Team < ActiveRecord::Base
  has_one :organization, as: :organizable
  has_many :contracts, through: :organization
  has_many :humen, through: :contracts
  has_many :professions, through: :humen
  has_many :players,
    through: :professions,
    source: "professionable",
    source_type: 'Player'

  belongs_to :federation
  has_and_belongs_to_many :competitions
  has_many :home_games, class_name: "Game", foreign_key: "home_id"
  has_many :guest_games, class_name: "Game", foreign_key: "guest_id"
  has_many :games, through: :competitions
  has_many :points
  has_many :results

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :short_name, presence: true, length: { maximum: 10 }, uniqueness: true
  validates :abbreviation, presence: true, length: { maximum: 3 }, uniqueness: true
  validates :federation, presence: true

  scope :without_players, -> {
    includes(:players).
    includes(:contracts).
    where(contracts: {organization_id: nil})
  }

  def games
    Game.where("games.home_id = #{id} OR games.guest_id = #{id}")
  end

end
