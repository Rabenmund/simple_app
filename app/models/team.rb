class Team < ActiveRecord::Base
  attr_accessible :name, :short_name, :abbreviation
  
  validates :name, presence: true, length: { maximum: 30 }
  validates :short_name, presence: true, length: { maximum: 8 }
  validates :abbreviation, presence: true, length: { maximum: 3 }
  
  has_and_belongs_to_many :competitions

end