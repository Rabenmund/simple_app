class Appointment < ActiveRecord::Base
  belongs_to :appointable, polymorphic: true
  belongs_to :competition
  validates :appointed_at, presence: true

  after_create :add_competition

  def add_competition
    update_attributes(competition: appointable.competition)
  end
end
