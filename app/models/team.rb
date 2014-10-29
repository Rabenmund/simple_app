class Team < ActiveRecord::Base
  attr_accessible :name, :short_name, :abbreviation

  belongs_to :federation
  has_and_belongs_to_many :competitions
  has_many :home_games, class_name: "Game", foreign_key: "home_id"
  has_many :guest_games, class_name: "Game", foreign_key: "guest_id"
  has_many :points

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :short_name, presence: true, length: { maximum: 10 }, uniqueness: true
  validates :abbreviation, presence: true, length: { maximum: 3 }, uniqueness: true

  def games
    home_games + guest_games
  end

#   def games_by(league)
# #    home_games.where("teams.matchday_id IN ?", league.matchdays)
#     home_games.select(:matchday_id).map { |m| league.matchdays.includes? m }
#     home_games.map { |m| l.matchdays.include? m }
#   end
end
