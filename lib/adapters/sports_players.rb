class Adapters::PlayerStats
  @@url = "https://www.mysportsfeeds.com/api/feed/sample/pull/nba/2015-2016-regular/cumulative_player_stats.json?"

  def fetch_player_data
    #returns the raw data hash of schedules
    result = RestClient.get(@@url)
    hash = JSON.parse(result)
  end

  def create_player(val)
    #takes schedule data as input returns new schedule object

    player = Player.new do |p|
      p.first_name = val["player"]["FirstName"]
      p.last_name = val["player"]["LastName"]
      p.full_name = val["player"]["FirstName"].downcase + " "+val["player"]["LastName"].downcase
      p.number = val["player"]["JerseyNumber"]
      p.pos = val["player"]["Position"]
      p.total_pts = val["stats"]["Pts"]["#text"]
      p.ppg = val["stats"]["PtsPerGame"]["#text"]
      p.ast = val["stats"]["Ast"]["#text"]
      p.apg = val["stats"]["AstPerGame"]["#text"]
      p.reb = val["stats"]["Reb"]["#text"]
      p.rpg = val["stats"]["RebPerGame"]["#text"]
      p.to = val["stats"]["Tov"]["#text"]
      p.topg = val["stats"]["TovPerGame"]["#text"]
      p.mins = val["stats"]["MinSeconds"]["#text"]
      p.fg = val["stats"]["FgMade"]["#text"]
      p.fg_att = val["stats"]["FgAtt"]["#text"]
      p.fg_pct = val["stats"]["FgPct"]["#text"]
      p.fg_3pt_att = val["stats"]["Fg3PtAtt"]["#text"]
      p.fg_3pt = val["stats"]["Fg3PtMade"]["#text"]
      p.fg_3pt_pg = val["stats"]["Fg3PtMadePerGame"]["#text"]
      p.stl = val["stats"]["Stl"]["#text"]
      p.spg = val["stats"]["StlPerGame"]["#text"]
      p.blk = val["stats"]["Blk"]["#text"]
      p.blk_pg = val["stats"]["BlkPerGame"]["#text"]
      p.pf = val["stats"]["FoulPers"]["#text"]
      p.pf_pg = val["stats"]["FoulPersPerGame"]["#text"]
      p.team_name = val["team"]["Name"]
    end
    player
  end

  def seed_db
    #takes the data returned by the fetch schedule data function, then runs the create_schedule function then creates the db instances
    players = fetch_player_data["cumulativeplayerstats"]["playerstatsentry"]
    players.each do |val|
       p = create_player(val)
       Player.find_or_create_by(p.attributes)
    end
  end

end

#Adapters::PlayerStats.new.seed_db
