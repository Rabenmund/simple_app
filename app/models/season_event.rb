class SeasonEvent < ActiveRecord::Base
  include Appointable
  belongs_to :season

  def call
    # define what should be done if called in event child
    #
    # TODO: should the appointment be deleted here?
    #   ...or with a customized after_call hook
    #   ...or never
    #   ...how then find the next one?
  end
end
