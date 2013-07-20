# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TEAMS = 
{
  'MSV' => ['MSV Duisburg', 'Duisburg'],
  'FCB' => ['FC Bayern München', 'Bayern'],
  'HSV' => ['Hamburger SV', 'Hamburg'],
  'S04' => ['FC Schalke 04 Gelsenkirchen', 'Schalke'],
  'BVB' => ['Borussia Dortmund', 'Dortmund'],
  'FCN' => ['1.FC Nürnberg', 'Nürnberg'],
  'VfB' => ['VfB Stuttgart', 'Stuttgart'],
  'BSC' => ['Hertha BSC Berlin', 'Berlin'],
  'F95' => ['Fortuna Düsseldorf', 'Fortuna'],
  'VfL' => ['VfL Bochum', 'Bochum'],
  '1FC' => ['1.FC Köln', 'Köln'],
  'FCK' => ['1.FC Kaiserlautern', 'Lautern'],
  'BMg' => ['Borussia Mönchengladbach', 'Gladbach'],
  'AAa' => ['Alemannia Aachen', 'Aachen'],
  'SVW' => ['SV Werder Bremen', 'Bremen'],
  'H96' => ['SV Hannover 96', 'Hannover'],
  'Lok' => ['1.FC Lokomotive Leipzig', 'Leipzig'],
  'KSV' => ['KSV Hessen Kassel', 'Kassel']
}

TEAMS.each_key { |team| Team.create(name: TEAMS[team][0], short_name: TEAMS[team][1], abbreviation: team )}