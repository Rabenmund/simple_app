class Appointment < ActiveRecord::Base

  belongs_to :appointable, polymorphic: true
  # belongs_to :competition
  validates :appointed_at, presence: true
  validates_uniqueness_of :appointable_id, scope: :appointable_type

  # after_create :add_competition

  # def add_competition
  #   update_attributes(competition: appointable.competition)
  # end

end
