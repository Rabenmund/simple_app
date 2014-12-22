class Federation < ActiveRecord::Base
  validates :name, presence: true
  has_and_belongs_to_many :seasons
  has_many :teams, dependent: :destroy
  has_many :competitions
  has_many :appointments, through: :competitions
  has_many :cups
  has_many :relegations
  has_many :leagues

  validates :name, uniqueness: true
end
