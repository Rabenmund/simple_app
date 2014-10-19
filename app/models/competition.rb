class Competition < ActiveRecord::Base
  validates :name, presence: true
  validates :year, presence: true, numericality: true
  belongs_to :federation
  belongs_to :season
  has_and_belongs_to_many :teams
  has_many :matchdays, -> { order "number ASC" }, dependent: :destroy
  has_many :games, through: :matchdays

  before_save { self.competable_type = self.class.name }
end
