# coding: utf-8

class Matchday < ActiveRecord::Base
  attr_accessible :number
  belongs_to :competition
  has_many :games, dependent: :destroy
  validates :number, uniqueness: { scope: :competition_id }, presence: true, numericality: true

#  scope :not_finished, joins(:games).where("home_goals IS NULL OR guest_goals IS NULL")
#  scope :finished, joins(:games).where("home_goals IS NOT NULL AND guest_goals IS NOT NULL")

  # def self.finished
  #   Matchday.all.each { |m| all << m if m.games.not_finished.empty? }
  #   all
  # end
  # 
  # def self.not_finished
  #   Matchday.all.each { |m| all << m unless m.games.not_finished.empty? }
  #   all
  # end

  def finished?
    games.empty? ? false : games.not_finished.empty?
  end
end