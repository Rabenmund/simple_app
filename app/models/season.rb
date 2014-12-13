class Season < ActiveRecord::Base
  validates :year, numericality: true, presence: true
  has_and_belongs_to_many :federations
  has_many :appointments, through: :competitions
  has_many :competitions
  has_many :leagues
  has_many :cups
  has_many :relegations

  def teardown!
    return false if appointments.any?
    leagues.each do |l|
      l.finish!
    end
    DFBPattern.new(season: create_next).prepare!
  end

  private

  def create_next
    start_date = DateTime.new((year), 8, 2, 15, 30)
    start_date += (6 - start_date.wday)
    Season.create(year: year+1, start: start_date)
  end
end
