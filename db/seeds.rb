# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts ""
puts "Saison"
s = Season.create(year: 2010, start: "11.08.2010".to_datetime)
puts s.inspect

puts ""
puts "Verband"
f = s.federations.create(name: "DFB")
puts f.inspect

TEAMS =
[
    {
      abbr: 'BVB',
      name:'Borussia Dortmund',
      short_name: 'Dortmund'
    },
    {
      abbr: 'FCN',
      name:'1.FC Nürnberg',
      short_name: 'Nürnberg'
    },
    {
      abbr: 'Lok',
      name:'1.FC Lokomotive Leipzig',
      short_name: 'Leipzig'
    },
    {
      abbr: 'H96',
      name:'SV Hannover 96',
      short_name: 'Hannover'
    },
    {
      abbr: 'StK',
      name:'Stutgarter Kickers',
      short_name: 'Stuttg.K.'
    },
    {
      abbr: 'RWF',
      name:'Rot-Weiß Frankfurt',
      short_name: 'RW Frankf.'
    },
    {
      abbr: 'SCF',
      name:'SC Freiburg',
      short_name: 'Freiburg'
    },
    {
      abbr: 'KSC',
      name:'Karlsruher SC',
      short_name: 'Karlsruhe'
    },
    {
      abbr: 'BSC',
      name:'Hertha BSC Berlin',
      short_name: 'Berlin'
    },
    {
      abbr: 'CZJ',
      name:'FC Carl-Zeiss Jena',
      short_name: 'Jena'
    },
    {
      abbr: 'VfB',
      name:'VfB Stuttgart',
      short_name: 'Stuttg.'
    },
    {
      abbr: 'FCB',
      name:'FC Bayern München',
      short_name: 'Bayern'
    },
    {
      abbr: 'SGE',
      name: 'Eintracht Frankfurt',
      short_name: 'Frankfurt'
    },
    {
      abbr: 'KSV',
      name:'KSV Hessen Kassel',
      short_name: 'Kassel'
    },
    {
      abbr: 'SVW',
      name:'SV Werder Bremen',
      short_name: 'Bremen'
    },
    {
      abbr: 'EBs',
      name: 'Eintracht Braunschweig',
      short_name: "B'schweig"
    },
    {
      abbr: 'HRo',
      name: 'FC Hansa Rostock',
      short_name: 'Rostock'
    },
    {
      abbr: 'M05',
      name: '1.FSV Mainz 05',
      short_name: 'Mainz'
    },
    {
      abbr: 'S04',
      name:'Schalke 04 Gelsenkirchen',
      short_name: 'Schalke'
    },
    {
      abbr: 'VfL',
      name:'VfL Bochum',
      short_name: 'Bochum'
    },
    {
      abbr: 'RWE',
      name:'Rot-Weiß Essen',
      short_name: 'Essen'
    },
    {
      abbr: '1FC',
      name:'1.FC Köln',
      short_name: 'Köln'
    },
    {
      abbr: 'DSC',
      name:'DSC Arminia Bielefeld',
      short_name: 'Bielefeld'
    },
    {
      abbr: 'AAa',
      name:'Alemannia Aachen',
      short_name: 'Aachen'
    },
    {
      abbr: 'SGD',
      name:'SG Dynamo Dresden',
      short_name: 'Dresden'
    },
    {
      abbr: 'HSV',
      name:'Hamburger SV',
      short_name: 'Hamburg'
    },
    {
      abbr: 'TSV',
      name:'TSV 1860 München',
      short_name: 'TSV 1860'
    },
    {
      abbr: 'F95',
      name:'Fortuna Düsseldorf',
      short_name: 'Fortuna'
    },
    {
      abbr: 'TSG',
      name:'TSG 1899 Hoffenheim',
      short_name: 'Hoffenheim'
    },
    {
      abbr: 'SSV',
      name:'SSV Ulm 1846',
      short_name: 'Ulm'
    },
    {
      abbr: 'B04',
      name: 'Bayer 04 Leverkusen',
      short_name: 'Leverkusen'
    },
    {
      abbr: 'MSV',
      name: 'MSV Duisburg',
      short_name: 'Duisburg'
    },
    {
      abbr: 'SVD',
      name: 'SV Darmstadt 98',
      short_name: 'Darmstadt'
    },
    {
      abbr: 'FCK',
      name:'1.FC Kaiserlautern',
      short_name: 'Lautern'
    },
    {
      abbr: 'FVD',
      name:'FV Duisburg 08',
      short_name: 'FV DU 08'
    },
    {
      abbr: 'FCU',
      name:'FC Union Ruhr Essen',
      short_name: 'FCU Ruhr'
    },
    {
      abbr: 'FCS',
      name:'1.FC Saarbrücken',
      short_name: 'Saarbrück.'
    },
    {
      abbr: 'RWO',
      name:'Rot-Weiß Oberhausen',
      short_name: 'Oberhausen'
    },
    {
      abbr: 'WOL',
      name:'VfL Wolfsburg',
      short_name: 'Wolfsburg'
    },
    {
      abbr: 'BMg',
      name:'Bor. Mönchengladbach',
      short_name: 'Gladbach'
    },
    {
      abbr: 'FCM',
      name:'1.FC Magdeburg',
      short_name: 'Magdeburg'
    },
    {
      abbr: 'GrF',
      name:'SpVgg Greuther Fürth',
      short_name: 'Fürth'
    },
    {
      abbr: 'FCE',
      name:'FC Energie Cottbus',
      short_name: 'Cottbus'
    },
    {
      abbr: 'WSV',
      name:'Wuppertaler SV',
      short_name: 'Wuppertal'
    },
    {
      abbr: 'SCP',
      name:'SC Preußen Münster',
      short_name: 'Münster'
    },
    {
      abbr: 'Erf',
      name:'FC Rot-Weiß Erfurt',
      short_name: 'Erfurt'
    },
    {
      abbr: 'AUE',
      name:'FC Erzgebirge Aue',
      short_name: 'Aue'
    },
    {
      abbr: 'FSV',
      name:'FSV Frankfurt',
      short_name: 'FSV Fr.'
    },
    {
      abbr: 'UnB',
      name:'1.FC Union Berlin',
      short_name: 'U.Berlin'
    },
    {
      abbr: 'FCA',
      name:'FC Augsburg',
      short_name: 'Augsburg'
    },
    {
      abbr: 'KFC',
      name:'KFC Uerdingen',
      short_name: 'Uerdingen'
    },
    {
      abbr: 'Kob',
      name:'TuS Koblenz',
      short_name: 'Koblenz'
    },
    {
      abbr: 'Lüb',
      name:'VfB Lübeck',
      short_name: 'Lübeck'
    },
    {
      abbr: 'BFC',
      name:'FC Dynamo Berlin',
      short_name: 'Dynamo'
    },
    {
      abbr: 'KOf',
      name:'Kickers Offenbach',
      short_name: 'Offenbach'
    },
    {
      abbr: 'FCL',
      name:'FC Leverkusen',
      short_name: 'FC Lever.'
    },
    {
      abbr: 'SGW',
      name:'SG Wattenscheid 09',
      short_name: 'Wattensch.'
    },
    {
      abbr: 'UtM',
      name:'FC Utopia München',
      short_name: 'Utopia'
    },
    {
      abbr: 'SSR',
      name:'SSV Reinickendorf',
      short_name: 'Reinicken.'
    },
    {
      abbr: 'SCJ',
      name:'SC Jülich 1910',
      short_name: 'Jülich'
    },
    {
      abbr: 'FCH',
      name:'FC Heilbronn',
      short_name: 'Heilbronn'
    },
    {
      abbr: 'WaM',
      name:'SV Waldhof Mannheim',
      short_name: 'Mannheim'
    },
    {
      abbr: 'BSV',
      name:'BSV Kickers Emden',
      short_name: 'Emden'
    },
    {
      abbr: 'PrB',
      name:'Preußen Bochum',
      short_name: 'Pr.Bochum'
    },
    {
      abbr: 'SCC',
      name:'SC Charlottenburg',
      short_name: 'Charlot.'
    },
]

puts ""
puts "Mannschaften:"
TEAMS.each do |team|
  parameters =
    {
      name: team[:name],
      short_name: team[:short_name],
      abbreviation: team[:abbr]
    }
    result = f.teams.create(parameters)
  errors = result.errors.messages.any? ? result.errors.messages.inspect : "ok"
  puts team[:abbr]+": "+ errors
end

puts ""
puts "Cup"
c = f.cups.create(name: "DFB Pokal")
c.teams << f.teams.where(id: [1..64])
s.cups << c
c.prepare!

puts c.inspect
c.matchdays.map! {|m|puts m.inspect}
c.draws.map! {|d|puts d.inspect}
c.appointments.map! {|a|puts a.inspect}

puts ""
puts "Liga"
