class Season < ActiveRecord::Base
  validates :year, numericality: true, presence: true
  has_and_belongs_to_many :federations
  has_many :competitions
end
