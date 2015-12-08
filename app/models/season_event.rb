class SeasonEvent < ActiveRecord::Base
  include Appointable
  belongs_to :season
  validates :season, presence: true

  # eventable is not mandantory, but possible
  belongs_to :eventable, polymorphic: true

  # def call
  #   # define what should be done if called in event child
  #   #
  #   # TODO: should the appointment be deleted here?
  #   #   ...or with a customized after_call hook
  #   #   ...or never
  #   #   ...how then find the next one?
  #   #
  #   #   probably there is an eventable object
  #   #   then the default is to delegate call to it

  #   # eventable.call
  # end
end
