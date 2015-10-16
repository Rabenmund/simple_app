module Appointable
  extend ActiveSupport::Concern
  included do
    has_one :appointment, as: :appointable
    delegate :appointed_at, to: :appointment
    # attr_accessor :appoint_date
    # after_create :create_appointment
  end

  def call
    # to be defined in appointable child
  end

  # private

  # TODO refactor - date must be injected and validated

  # def create_appointment
    # Appointment.create(
      # appointable: self,
      # appointed_at: appoint_date || try(:performed_at))
  # end

end
