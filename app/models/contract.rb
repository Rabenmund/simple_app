class Contract < ActiveRecord::Base
  belongs_to :organization
  belongs_to :human

  scope :overlaps, ->(from, to) {
    joins(:human).
    where("((contracts.from <= ?) AND (contracts.to >= ?))", from, to)
  }

  def overlaps?
    overlaps.exists?
  end

  def overlaps
    siblings.overlaps from, to
  end

  validate :not_overlap

  def not_overlap
    errors.add(:key, 'darf sich nicht mit anderem Contract des Human überlappen') if overlaps?
  end

  # -1 is when you have a nil id, so you will get all persisted contracts
  def siblings
    human.contracts.where('contracts.id != ?', id || -1)
  end
end
