# coding: utf-8

class Matchday < ActiveRecord::Base
  belongs_to :competition
  has_many :games, dependent: :destroy
  
  validates :number, uniqueness: { scope: :competition_id }, presence: true, numericality: true
end