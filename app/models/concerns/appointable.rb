module Appointable
  extend ActiveSupport::Concern
  included do
    has_one :appointment, as: :appointable
    after_save :ensure_appointment
    attr_accessor :start_date
  end

  private

  def ensure_appointment
    if appointment
      if start_date && start_date != appointment.start_date
        appointment.update_attributes(start_date: start_date)
      end
    else
      Appointment.create(appointable: self, appointed_at: start_date)
    end
  end
end
