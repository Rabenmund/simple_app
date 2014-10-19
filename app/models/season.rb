class Season < ActiveRecord::Base
  validates :year, numericality: true, presence: true
  has_and_belongs_to_many :federations
  has_many :competitions
  has_many :leagues
  has_many :cups
  has_many :relegations
end
