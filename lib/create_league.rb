class CreateLeague
  
  def self.create(args)
    return "no league given" unless args.has_key?(:league)
    return "no teams given" unless args.has_key?(:teams)
    return "number of teams allowed: [18]" unless args[:teams].size == 18

    ActiveRecord::Base.transaction do
    
      league = League.create!(args[:league])
      SPIELTAGE.each do |number, games|
        matchday = league.matchdays.create!(number: number)
        SPIELTAGE[number].each do |game|
          matchday.games.create(home_id: args[:teams][game[0]-1].id, guest_id: args[:teams][game[1]-1].id)
        end
      end
      
    end
  end
  
  SPIELTAGE =
  {
    1 => 
    [
      [1,2],
      [3,4],
      [5,6],
      [7,8],
      [9,10],
      [11,12],
      [13,14],
      [15,16],
      [17,18]
    ],
    
    2 => 
    [
      [2,3],
      [4,5],
      [6,7],
      [8,9],
      [10,11],
      [12,13],
      [14,15],
      [16,17],
      [18,1]
    ]
  }
  
end
