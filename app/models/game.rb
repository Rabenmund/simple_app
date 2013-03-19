# coding: utf-8

class Game < ActiveRecord::Base
  attr_accessible :home_id, :guest_id, :home_goals, :guest_goals
  belongs_to :matchday
  has_one :competition, through: :matchday
  validates_presence_of :home_id, :guest_id
  validates_numericality_of :home_id, :guest_id
  validates :home_goals, numericality: { only_integer: true }, allow_nil: true
  validates :guest_goals, numericality: { only_integer: true }, allow_nil: true
  
end