class Appointment < ActiveRecord::Base

  belongs_to :appointable, polymorphic: true
  validates :appointed_at, presence: true
  # validates_uniqueness_of :appointable_id, scope: :appointable_type # TODO: need?

  def add_a_minute!
    update_attributes(appointed_at: appointed_at + 1.minute)
  end

end
