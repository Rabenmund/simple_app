class Competition < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :federation
  belongs_to :season
  has_and_belongs_to_many :teams
  has_many :matchdays, -> { order "number ASC" }, dependent: :destroy
  has_many :games, through: :matchdays
  has_many :appointments

  before_save { self.competable_type = self.class.name }

  def ordered_teams
    teams.order("competitions_teams.id")
  end

  private

  def members
    @members ||= teams.pluck :id
  end

  def matchday_schema
    {} # to be defined in child
  end

  def create_matchdays!(number)
    matchdays.create(number: number+1, start: StartDate.new(start, days_since_season_start(number)).start_date)
  end

  def days_since_season_start(number)
    matchday_schema[number_of_matchdays][number].days
  end

  def number_of_matchdays
    {0=> 0}[members.size] || 0 # to be set in child
  end

end
