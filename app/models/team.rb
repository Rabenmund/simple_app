class Team < ActiveRecord::Base
  attr_accessible :name, :short_name, :abbreviation
  
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :short_name, presence: true, length: { maximum: 8 }, uniqueness: true
  validates :abbreviation, presence: true, length: { maximum: 3 }, uniqueness: true
  
  has_and_belongs_to_many :leagues

end