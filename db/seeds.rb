# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TEAMS = 
{
  'MSV' => 
    {
      name: 'MSV Duisburg', 
      short_name: 'Duisburg'
    },
  'FCB' => 
    {
      name:'FC Bayern München',  
      short_name: 'Bayern'
    },
  'HSV' => 
    {
      name:'Hamburger SV', 
      short_name: 'Hamburg'
    },
  'S04' => 
    {
      name:'Schalke 04 Gelsenkirchen', 
      short_name: 'Schalke'
    },
  'BVB' => 
    {
      name:'Borussia Dortmund', 
      short_name: 'Dortmund'
    },
  'FCN' => 
    {
      name:'1.FC Nürnberg', 
      short_name: 'Nürnberg'
    },
  'VfB' => 
    {
      name:'VfB Stuttgart', 
      short_name: 'Stuttg.'
    },
  'BSC' => 
    {
      name:'Hertha BSC Berlin', 
      short_name: 'Berlin'
    },
  'F95' => 
    {
      name:'Fortuna Düsseldorf', 
      short_name: 'Fortuna'
    },
  'VfL' => 
    {
      name:'VfL Bochum', 
      short_name: 'Bochum'
    },
  '1FC' => 
    {
      name:'1.FC Köln', 
      short_name: 'Köln'
    },
  'FCK' => 
    {
      name:'1.FC Kaiserlautern', 
      short_name: 'Lautern'
    },
  'BMg' => 
    {
      name:'Bor. Mönchengladbach', 
      short_name: 'Gladbach'
    },
  'AAa' => 
    {
      name:'Alemannia Aachen', 
      short_name: 'Aachen'
    },
  'SVW' => 
    {
      name:'SV Werder Bremen', 
      short_name: 'Bremen'
    },
  'H96' => 
    {
      name:'SV Hannover 96', 
      short_name: 'Hannover'
    },
  'Lok' => 
    {
      name:'1.FC Lokomotive Leipzig', 
      short_name: 'Leipzig'
    },
  'KSV' => 
    {
      name:'KSV Hessen Kassel', 
      short_name: 'Kassel'
    }
}

puts ""
puts "Mannschaften:"
TEAMS.each_key do |team|
  parameters =
    { 
      name: TEAMS[team][:name], 
      short_name: TEAMS[team][:short_name], 
      abbreviation: team 
    }
  result = Team.create(parameters)
  errors = result.errors.messages.any? ? result.errors.messages.inspect : "ok"
  puts team+": "+ errors
end

puts ""
puts "Ligen:"
LIGAS =
{
  '1.Bundesliga' => 
  {
    name: "1.Bundesliga",
  },
  '2.Bundesliga' => 
  {
    name: "2.Bundesliga",
  }
}

LIGAS.each_key do |liga|
  parameters = 
  {
    name: LIGAS[liga][:name]
  }
  result = CreateLeague.create(league: parameters, teams: Team.all)
  puts liga+": ok"
end

# finish first matchday

League.first.matchdays.each do |md|
  md.games.each do |n|
    puts "Spiel: #{n} beendet."
    g = Game.find(n)
    g.home_goals = rand(5)
    g.guest_goals = rand(5)
    g.finished = true
    CalculatePoints.calculate(g)
    g.save
  end
end
