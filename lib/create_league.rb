class CreateLeague
  
  def self.create(args)
    return "no league given" unless args.has_key?(:league)
    return "no teams given" unless args.has_key?(:teams)
    return "number of teams allowed: [18]" unless args[:teams].size == 18

    ActiveRecord::Base.transaction do
    
      league = League.create!(args[:league])
      puts args[:teams].inspect
      args[:teams].each do |team|
        puts team.inspect
        league.teams << team
      end
      
      puts "liga teams ", league.teams.inspect
      
      SPIELTAGE.each do |number, games|
        matchday = league.matchdays.create!(number: number)
        SPIELTAGE[number].each do |game|
          matchday.games.create(home_id: args[:teams][game[0]-1].id, guest_id: args[:teams][game[1]-1].id)
        end
      end
      
      SPIELTAGE.each do |number, games|
        matchday = league.matchdays.create!(number: number+17)
        SPIELTAGE[number].each do |game|
          matchday.games.create(home_id: args[:teams][game[1]-1].id, guest_id: args[:teams][game[0]-1].id)
        end
      end
      
    end
  end
  
  
  
  SPIELTAGE =
  {
    1 => 
    [
      [1,10],
      [2,11],
      [3,12],
      [4,13],
      [5,14],
      [6,15],
      [7,16],
      [8,17],
      [9,18]
    ],
    2 => 
    [
      [1,11],
      [2,12],
      [3,13],
      [4,14],
      [5,15],
      [6,16],
      [7,17],
      [8,18],
      [9,10]
    ],
     3 => 
    [
      [1,12],
      [2,13],
      [3,14],
      [4,15],
      [5,16],
      [6,17],
      [7,18],
      [8,10],
      [9,11]
    ],
    4 => 
    [
      [1,13],
      [2,14],
      [3,15],
      [4,16],
      [5,17],
      [6,18],
      [7,10],
      [8,11],
      [9,12]
    ],
    5 => 
    [
      [1,14],
      [2,15],
      [3,16],
      [4,17],
      [5,18],
      [6,10],
      [7,11],
      [8,12],
      [9,13]
    ],
    6 => 
    [
      [1,15],
      [2,16],
      [3,17],
      [4,18],
      [5,10],
      [6,11],
      [7,12],
      [8,13],
      [9,14]
    ],
    7 => 
    [
      [1,16],
      [2,17],
      [3,18],
      [4,10],
      [5,11],
      [6,12],
      [7,13],
      [8,14],
      [9,15]
    ],
    8 => 
    [
      [1,17],
      [2,18],
      [3,10],
      [4,11],
      [5,12],
      [6,13],
      [7,14],
      [8,15],
      [9,16]
    ],
    9 => 
    [
      [1,18],
      [2,10],
      [3,11],
      [4,12],
      [5,13],
      [6,14],
      [7,15],
      [8,16],
      [9,17]
    ],
    10 => 
    [
      [1,10],
      [2,11],
      [3,12],
      [4,13],
      [5,14],
      [6,15],
      [7,16],
      [8,17],
      [9,18]
    ],
    11 => 
    [
      [1,11],
      [2,12],
      [3,13],
      [4,14],
      [5,15],
      [6,16],
      [7,17],
      [8,18],
      [9,10]
    ],
     12 => 
    [
      [1,12],
      [2,13],
      [3,14],
      [4,15],
      [5,16],
      [6,17],
      [7,18],
      [8,10],
      [9,11]
    ],
    13 => 
    [
      [1,13],
      [2,14],
      [3,15],
      [4,16],
      [5,17],
      [6,18],
      [7,10],
      [8,11],
      [9,12]
    ],
    14 => 
    [
      [1,14],
      [2,15],
      [3,16],
      [4,17],
      [5,18],
      [6,10],
      [7,11],
      [8,12],
      [9,13]
    ],
    15 => 
    [
      [1,15],
      [2,16],
      [3,17],
      [4,18],
      [5,10],
      [6,11],
      [7,12],
      [8,13],
      [9,14]
    ],
    16 => 
    [
      [1,16],
      [2,17],
      [3,18],
      [4,10],
      [5,11],
      [6,12],
      [7,13],
      [8,14],
      [9,15]
    ],
    17 => 
    [
      [1,17],
      [2,18],
      [3,10],
      [4,11],
      [5,12],
      [6,13],
      [7,14],
      [8,15],
      [9,16]
    ]
  }
  
end

