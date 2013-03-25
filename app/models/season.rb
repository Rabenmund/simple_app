# coding: utf-8

class Season < ActiveRecord::Base
  attr_accessible :name, :competition_ids
  has_many :competitions
  has_many :matchdays, through: :competitions
  validates :name, presence: true, length: { maximum: 30 }
end