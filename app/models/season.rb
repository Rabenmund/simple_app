class Season < ActiveRecord::Base
  validates :year, numericality: true, presence: true
  has_and_belongs_to_many :federations
  has_many :competitions
  has_many :leagues
  has_many :cups
  has_many :relegations

  def self.create_next
    previous = order(:year).last
    year = previous.year + 1
    start_date = DateTime.new((year-1), 8, 2, 15, 30)
    start_date += (6 - start_date.wday)
    create(year: year, start: start_date)
  end
end
