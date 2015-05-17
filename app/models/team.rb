class Team < ActiveRecord::Base
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

  def games
    Game.where("games.home_id = #{id} OR games.guest_id = #{id}")
  end

  def system
    [4,4,2] # will be instantiated later
  end

  def initiative
    keeper   *  1.00 +
    defense  *  1.00 +
    midfield *  2.00 +
    attack   *  1.00
  end

  def attacking
    keeper   *  0.00 +
    defense  *  0.50 +
    midfield *  1.00 +
    attack   *  2.50
  end

  def defending
    keeper   *  3.00 +
    defense  *  2.50 +
    midfield *  1.00 +
    attack   *  0.50
  end
end
