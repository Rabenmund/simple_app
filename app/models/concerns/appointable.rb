module Appointable
  extend ActiveSupport::Concern
  included do
    attr_accessor :appoint_date
    has_one :appointment, as: :appointable
    after_create :create_appointment
  end

  def finish!
    super
    appointment
  end

#   def appointment
#     @appointment ||= Appointment.find_by(appointable: self)
#   end

  private

  def create_appointment
    Appointment.create(appointable: self, appointed_at: appoint_date || start_date)
  end

  def ensure_appointment
    if appointment
      if appoint_date && appoint_date != appointment.appointed_at
        appointment.update_attributes(appointed_at: appoint_date)
      end
    else
      Appointment.create(appointable: self, appointed_at: appoint_date || start_date)
    end
  end

end
