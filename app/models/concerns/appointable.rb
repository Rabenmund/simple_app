module Appointable
  extend ActiveSupport::Concern
  included do
    attr_accessor :start_date
    has_one :appointment, as: :appointable
    after_save :ensure_appointment
  end

  private

  def ensure_appointment
    if appointment
      if start_date && start_date != appointment.appointed_at
        appointment.update_attributes(appointed_at: start_date)
      end
    else
      Appointment.create(appointable: self, appointed_at: start_date)
    end
  end
end
