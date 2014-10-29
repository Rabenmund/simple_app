class Appointment < ActiveRecord::Base
  belongs_to :appointable, polymorphic: true
  validates :appointed_at, presence: true
end
