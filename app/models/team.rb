class Team < ActiveRecord::Base
  attr_accessible :name, :short_name, :abbreviation
  
  has_and_belongs_to_many :leagues
  has_many :home_games, class_name: "Game", foreign_key: "home_id"
  has_many :guest_games, class_name: "Game", foreign_key: "guest_id"
  
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :short_name, presence: true, length: { maximum: 8 }, uniqueness: true
  validates :abbreviation, presence: true, length: { maximum: 3 }, uniqueness: true
  
end