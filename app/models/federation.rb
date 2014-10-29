class Federation < ActiveRecord::Base
  validates :name, presence: true
  has_and_belongs_to_many :seasons
  has_many :teams
  has_many :competitions
  has_many :cups
  has_many :relegations
  has_many :leagues
end
