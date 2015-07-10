class Profession < ActiveRecord::Base
  belongs_to :human
  belongs_to :professionable, polymorphic: true

  scope :inactive, -> { where(active: false) }
  scope :active, -> { where(active: true) }
end
