module Appointable
  extend ActiveSupport::Concern
  included do
    attr_accessor :appoint_date
    has_one :appointment, as: :appointable
    after_create :create_appointment
  end

  private

  def create_appointment
    a = Appointment.create(appointable: self, appointed_at: appoint_date || performed_at)
  end

end
