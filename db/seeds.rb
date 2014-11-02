# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_games(c,m,games)
  puts ["1.Runde", "2.Runde", "Achtelfinale", "Viertelfinale", "Halbfinale", "Finale"][m.number.to_i-1]
  games.each do |g|
    options = {home: c.teams.find_by(abbreviation: g[0].to_s), guest: c.teams.find_by(abbreviation: g[1].to_s), home_goals: g[2], guest_goals: g[3], home_half_goals: g[4], guest_half_goals: g[5], performed_at: m.start, finished: true, level: c.level}
    options.merge! home_full_goals: g[6], guest_full_goals: g[7]  if g[6]
    options.merge!(home_xtra_goals: g[8], guest_xtra_goals: g[9]) if g[8]
    game = m.games.create(options)
    puts "#{game.home.name} - #{game.guest.name} (#{game.home_half_goals}:#{game.guest_half_goals}) #{game.home_goals}:#{game.guest_goals} #{addition(game)}"
  end
  puts " "
end

def addition(game)
  return "n.E." if game.home_xtra_goals
  return "n.V." if game.home_full_goals
  ""
end

puts ""
puts "Saison"
s = Season.create(year: 2010, start: "08.08.2009".to_datetime)
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
      abbr: 'PrM',
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
      abbr: 'WaM',
      name:'SV Waldhof Mannheim',
      short_name: 'Mannheim'
    },
    {
      abbr: 'PrB',
      name:'Preußen Bochum',
      short_name: 'Pr.Bochum'
    },
    {
      abbr: 'SGU',
      name:'SG Union Solingen',
      short_name: 'Solingen'
    },
    {
      abbr: 'SVB',
      name:'SV Babelsberg 03',
      short_name: 'Potsdam'
    },
    {
      abbr: 'RWA',
      name:'Rot-Weiß Ahlen',
      short_name: 'Ahlen'
    },
    {
      abbr: 'BSV',
      name:'BSV Kickers Emden',
      short_name: 'Emden'
    },
    {
      abbr: 'SCC',
      name:'SC Charlottenburg',
      short_name: 'Charlot.'
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
c = f.cups.create(name: "DFB Pokal", level: 1)
c.teams << f.teams.where(id: [1..64])
s.cups << c
c.prepare!

GAMES1 = [
  [:FCU,:CZJ,0,1,0,1],
  [:WSV,:VfL,0,2,0,1],
  [:Lüb,:VfB,1,2,1,1,1,1],
  [:UtM,:SGE,0,6,0,2],
  [:BMg,:RWF,0,2,0,0],
  [:FSV,:BVB,0,1,0,0,0,0],
  [:FCE,:SCF,0,2,0,1],
  [:Kob,:FCN,3,4,1,3],
  [:FCL,:SSV,5,6,0,0,0,0,1,1],
  [:FVD,:WOL,2,1,1,1],
  [:PrB,:S04,2,4,2,1,2,2],
  [:BFC,:DSC,0,1,0,1],
  [:KFC,:RWO,4,1,3,1],
  [:SGU,:F95,2,1,1,0],
  [:FCM,:KSV,4,2,2,2],
  [:WaM,:M05,1,4,1,3],
  [:FCA,:AAa,0,3,0,0],
  [:SSR,:MSV,4,5,1,1,1,1,1,1],
  [:KOf,:SVW,1,3,1,3],
  [:SGW,:HRo,1,5,1,2],
  [:FCK,:EBs,7,6,2,2,3,3,3,3],
  [:AUE,:RWE,0,2,0,2],
  [:PrM,:TSV,1,4,1,1],
  [:SGD,:TSG,3,0,2,0],
  [:SVB,:Lok,3,2,3,0],
  [:UnB,:KSC,1,5,1,3],
  [:GrF,:FCS,0,1,0,0],
  ["1FC",:StK,1,0,0,0,0,0],
  [:Erf,:SVD,1,2,1,0],
  [:RWA,:H96,0,1,0,0],
  [:B04,:BSC,2,0,0,0],
  [:FCB,:HSV,2,0,1,0],
]

GAMES2 = [
  [:SSV,:VfL,1,2,1,1],
  [:FCB,:M05,4,5,0,0,0,0,0,0],
  [:H96,:SGD,2,3,1,2],
  [:HRo,:SGE,0,1,0,1],
  [:MSV,:RWE,3,5,0,0,1,1,2,2],
  [:VfB,:TSV,0,2,0,1],
  ["1FC",:CZJ,1,0,0,0],
  [:RWF,:DSC,2,4,2,2,2,2,2,2],
  [:AAa,:FCN,2,3,1,3],
  [:BVB,:B04,1,0,1,0],
  [:FCM,:KSC,2,1,1,1],
  [:KFC,:SCF,1,2,0,2],
  [:FCK,:SVW,2,3,1,1],
  [:SGU,:S04,3,2,2,2,2,2],
  [:SVD,:FCS,2,1,0,1],
  [:FVD,:SVB,3,1,2,1]
]

GAMES3 = [
  [:FCM,:RWE,0,3,0,2],
  [:FVD,:SCF,2,1,2,1],
  [:FCN,:SGD,3,1,1,1,1,1],
  [:M05,:SGE,1,0,1,0],
  [:SVW,:DSC,4,3,0,0,0,0,0,0],
  [:SGU,:VfL,1,2,1,0],
  ["1FC",:TSV,4,3,0,0,0,0,0,0],
  [:SVD,:BVB,3,4,0,0,0,0,0,0]
]

GAMES4 = [
  [:SVW,:VfL,0,3,0,2],
  ["1FC",:BVB,1,3,0,0,1,1],
  [:M05,:RWE,2,1,0,1],
  [:FVD,:FCN,1,3,1,1]
]

GAMES5 = [
  [:BVB,:FCN,6,4,2,2,3,3,3,3],
  [:VfL,:M05,1,2,0,1]
]

GAMES6 = [
  [:M05,:BVB,0,1,0,0,0,0]
]


create_games(c, c.matchdays[0], GAMES1)
create_games(c, c.matchdays[1], GAMES2)
create_games(c, c.matchdays[2], GAMES3)
create_games(c, c.matchdays[3], GAMES4)
create_games(c, c.matchdays[4], GAMES5)
create_games(c, c.matchdays[5], GAMES6)

puts c.inspect
puts ""
c.matchdays.map! {|m|puts m.inspect}
puts ""
c.draws.map! {|d|puts d.inspect}

puts ""
puts "Liga"

l = f.leagues.create(name: "Bundesliga", level: 1)
[7,10,3,6,19,9,15,12,2,8,14,13,20,5,11,4,1,21].each do |id|
  l.teams << f.teams.find(id)
end
s.leagues << l
l.prepare!

puts l.inspect

RESULTS = [
  [2,1,2,3,3,0,4,0,0,1,0,1,0,0,0,2,2,0,2,3,0,1,1,1,1,0,2,0,2,1,2,2,2,1,3,1],
  [1,0,1,1,2,0,3,0,0,2,0,3,1,0,1,1,2,0,3,1,2,0,2,2,1,1,1,2,0,0,0,2,0,0,0,2],
  [0,0,2,1,1,1,1,1,1,0,3,2,1,0,2,0,0,0,0,1,0,0,0,1,3,1,3,1,0,1,0,1,1,1,2,1],
  [0,0,1,1,0,3,1,4,0,1,1,2,0,0,1,1,1,2,1,2,0,2,1,3,1,0,1,0,0,0,0,0,2,1,4,1],
  [0,2,0,2,1,0,1,1,0,1,0,1,0,2,0,3,0,0,2,1,2,1,2,2,0,0,1,0,2,0,2,0,3,0,5,0],
  [0,0,0,0,0,0,1,0,1,1,1,1,0,0,2,0,0,2,1,2,1,0,1,3,2,0,3,0,0,0,2,2,0,0,0,3],
  [1,2,2,2,1,2,1,3,1,2,2,3,2,0,2,1,1,0,2,2,1,2,2,2,1,0,1,1,1,0,1,0,0,1,0,1],
  [1,2,2,2,1,0,0,0,1,0,1,1,0,1,1,3,0,2,1,3,0,0,0,0,0,3,1,6,0,1,0,2,0,0,3,0],
  [1,0,2,1,1,0,1,1,0,1,3,1,3,1,3,2,0,1,1,3,1,1,1,1,1,1,1,1,0,1,1,2,0,0,2,0],
  [1,1,1,2,1,0,1,1,1,2,2,2,1,0,2,0,0,1,0,1,1,0,2,0,1,1,1,1,1,0,1,1,1,1,1,1],
  [0,1,1,2,0,1,1,2,1,1,3,2,1,1,2,1,1,2,1,2,0,0,0,4,2,0,2,2,2,0,2,0,2,2,3,3],
  [1,1,2,1,1,0,2,0,1,0,1,0,2,1,2,2,1,0,1,1,0,0,1,1,1,1,2,2,0,0,0,1,2,2,3,2],
  [1,1,3,1,1,1,3,2,1,0,1,1,0,0,0,2,1,0,1,0,0,0,0,1,0,0,2,0,0,1,1,1,0,0,1,0],
  [0,0,0,1,0,1,0,2,2,0,2,1,1,0,1,2,2,0,3,0,1,0,1,1,1,0,1,1,0,0,0,0,4,2,6,2],
  [0,0,1,0,0,2,0,4,1,1,2,1,0,0,0,0,1,2,1,2,1,0,1,1,0,0,1,1,0,3,0,3,1,0,1,0],
  [1,0,2,1,0,0,1,1,2,1,2,2,2,1,2,1,0,0,0,1,0,1,1,1,0,1,0,2,0,1,2,1,2,0,4,1],
  [0,0,1,1,0,1,0,1,0,2,2,3,0,0,0,0,0,1,2,1,0,1,0,2,0,1,1,2,0,3,0,3,1,1,2,1],
  [2,0,2,0,1,1,1,1,0,0,2,0,2,0,3,0,0,0,1,2,2,0,4,0,0,0,0,0,0,0,1,0,0,0,0,0],
  [1,0,1,0,1,3,1,3,0,1,1,1,1,0,2,0,3,0,3,2,0,0,1,0,1,0,3,3,1,2,1,4,3,1,3,3],
  [3,0,5,1,1,1,1,3,0,2,0,5,0,0,0,1,0,1,1,1,0,1,1,2,2,2,4,2,0,2,0,2,0,0,0,0],
  [1,0,1,1,2,2,2,4,0,2,0,3,2,1,2,3,1,1,1,1,1,2,2,3,2,0,3,1,1,0,2,3,0,0,0,0],
  [0,0,0,0,0,1,2,1,1,1,1,1,1,0,2,0,0,1,2,2,0,1,1,2,1,0,1,1,0,1,1,1,0,2,0,4],
  [1,1,1,1,0,0,0,0,0,0,0,1,0,0,0,0,2,1,4,1,1,0,1,1,0,0,0,0,2,0,2,0,0,0,1,0],
  [0,0,1,0,0,2,0,2,0,0,0,0,0,0,0,0,1,2,1,4,2,2,2,2,0,0,1,0,1,0,2,0,0,2,2,3],
  [0,1,2,2,1,4,1,4,0,0,0,2,0,0,1,1,2,1,2,2,0,0,0,0,0,0,1,0,3,0,3,0,0,0,0,1],
  [0,0,1,0,1,0,1,0,0,1,1,2,0,0,2,0,1,0,1,0,1,0,1,1,1,0,2,1,1,0,1,3,0,0,0,2],
  [4,1,4,2,3,2,3,4,1,0,1,0,1,0,1,0,0,0,0,1,1,0,1,0,3,0,4,0,2,0,2,0,0,2,0,2],
  [0,1,1,2,0,2,0,2,1,2,2,3,0,0,0,0,1,1,2,1,0,0,0,0,0,0,1,0,1,0,2,1,0,3,0,3],
  [0,1,2,1,1,0,1,0,2,1,3,2,1,1,2,1,0,0,2,1,0,0,0,0,0,1,2,2,1,1,1,1,0,0,0,1],
  [1,0,1,2,2,1,2,2,1,1,1,1,1,0,1,1,1,1,3,1,1,0,1,0,1,1,2,2,0,0,4,2,1,0,2,1],
  [0,0,0,0,0,0,2,1,0,2,1,3,0,0,0,2,0,2,0,2,0,0,0,2,0,1,0,1,0,0,1,0,0,1,0,1],
  [0,0,0,0,2,1,3,1,1,0,2,2,0,0,1,1,0,1,0,1,1,0,1,0,0,1,0,2,0,1,0,2,0,1,0,1],
  [1,2,3,2,1,1,2,1,1,2,1,2,1,0,1,0,2,0,3,0,1,0,2,0,0,1,1,3,0,0,1,0,1,0,2,0],
  [0,0,0,0,0,0,1,0,1,0,1,1,2,0,2,0,0,0,1,0,0,3,0,3,2,0,3,0,1,0,1,1,0,0,0,1],
]
  RESULTS.each do |m|
  number = (RESULTS.index(m))+1
  md = l.matchdays.find_by(number: number)
  9.times do |g|
    rel = g*4
    md.games[g].update_attributes(home_half_goals: m[rel], guest_half_goals: m[rel+1], home_goals: m[rel+2], guest_goals: m[rel+3])
    md.games[g].finish!
  end
end

puts ""
l.matchdays.each do |m|
  puts "#{m.number}. Spieltag: #{m.start}"
  m.games.order(:id).map! {|g|puts "#{Team.find(g.home_id).name} - #{Team.find(g.guest_id).name} (#{g.home_half_goals}:#{g.guest_half_goals}) #{g.home_goals}:#{g.guest_goals}" }
  puts ""
end

puts l.inspect
puts c.inspect
puts Competition.all.inspect
