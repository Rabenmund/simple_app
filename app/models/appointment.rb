class Appointment < ActiveRecord::Base

  belongs_to :appointable, polymorphic: true
  validates :appointed_at, presence: true
  validates_uniqueness_of :appointable_id, scope: :appointable_type # TODO: need?

end
