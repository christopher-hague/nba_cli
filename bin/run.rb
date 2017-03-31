require_relative '../config/environment'
#Adapters::PlayerStats.new.seed_db
#Adapters::SportsSchedule.new.seed_db
def welcome
  puts "Welcome to the NBA stat tracker!"
  display_nba_image1
  prompt
end

def prompt
  puts "What are you interested in?"
  puts "---------------------------"
  puts "Enter 1 for Player stats"
  puts "Enter 2 for Team stats"
  puts "Enter 3 for Schedules"
  puts "---------------------------"
  user_input(input)
end

def input
  gets.chomp
end

def user_input(val)
  if val == "1"
    # display player prompt
    player_prompt
  elsif val == "2"
    # display team prompt
    team_prompt
  elsif val == "3"
    # display schedule prompt
    schedule_prompt
  else
    # inform invalid option
  end
end

def player_prompt
  puts "Enter player to see stats"
  name = input
  display_player_summary(name)

  puts "Enter 'all' to see complete stats"
  puts "Enter 'game' to see when '#{name}' is playing next"
  option = input
  if option.downcase == 'all'
    display_player_stats(name)
  elsif option.downcase == 'game'
    display_player_schedule(name)
  end
  # if player iexists in db
    # return more/return player
  #else
    # inform player not exists
end

def schedule_prompt
  # a range of dates would be nice
  puts "Enter 'date' to view schedule for specific date"
  puts "Enter 'team' to view schedule for a team"
  option = input
  if option == 'date'
    schedule_by_date
  elsif option == 'team'
    schedule_by_team
  end
  # if date
    # list games on that date
  # else
    # inform no dates/invalid date
end

def display_player_summary(name)
  # binding.pry
  player = Player.find_by full_name: name.downcase
  puts "------------------------------------------------------------------------"
  puts "#{player.first_name} #{player.last_name} plays for the #{player.team_name}"
  puts "Per game statistics for #{player.first_name} #{player.last_name}:"
  puts "Points: " + player.ppg.to_s
  puts "Rebounds: " + player.rpg.to_s
  puts "Assists: " + player.apg.to_s
  puts "Turnovers: " + player.topg.to_s
  puts "Steals: " + player.spg.to_s
  puts "Blocks: " + player.blk_pg.to_s
end

def display_player_stats(name)
  puts "------------------------------------------------------------------------"
  player = Player.find_by full_name: name.downcase
  player.attributes.each do |k, v|
    if k == "mins"
      puts "#{k}: #{v.to_i / 60}"
    elsif k == "full_name" || k == "first_name" || k == "last_name" || k == "id"
      next
    elsif v == nil
      puts "#{k}: 0"
    else
      puts "#{k}: #{v}"
    end
  end
  prompt
end

def display_player_schedule(name)
  team = Player.find_by(full_name: name.downcase).team_name
  schedule = Schedule.find_by(away_team: team) || Schedule.find_by(home_team: team)
  schedule.away_team == team ? other_team = schedule.home_team : other_team = schedule.away_team
  puts "#{name} and the #{team} will be playing the #{other_team} on #{schedule.date} at #{schedule.location}."
  puts"------------------------------------------------------------------------"
  prompt
end

def schedule_by_date
  puts "Enter a date for schedule | dd / mm / yyyy"
  date = input
  #will look schedule by date and return scehdule item
  date = date.split("/").reverse.join("-")
  schedules = Schedule.where("date = '#{date}'")
  puts "#{date} date schedule will go here"
  puts "Here are the teams that are playing on that day"
  display_schedule(schedules)
end

def schedule_by_team
  puts "Enter a team to view its schedule"
  team = input
  schedules = Schedule.where("home_team = '#{team}' OR  away_team = '#{team}'").limit(10)
  puts "Here are the next 10 games that the #{team} will be playing"
  display_schedule(schedules)
  #iterate over the teams and print the schedule
end

def display_schedule(schedules)
  schedules.each do |schedule|
    puts "---------------------------------------------------------------------"
    puts schedule.date
    puts schedule.away_team
    puts schedule.home_team
    puts schedule.location
    puts "---------------------------------------------------------------------"
  end
end


#-------------------------------------------------------------------------------
def team_prompt
  puts "Enter team to see stats"
  name = input
  # we need to account for invalid team names, else program will close
  display_team_summary(name)

  puts "Enter 'all' to see complete stats"

  if input.downcase == "all"
    display_team_stats(name)
  end
end

def display_team_summary(team_name)
  # binding.pry
  team = Team.find_by name: team_name.split(" ").map { |name| name.capitalize }.join(" ") # downcase not working
  if team
    puts " " * 30
    puts "-" * 30
    puts "Here is a summary of the #{team.city} #{team.name}'s stats for this season."
    puts "Per game statistics for the #{team.city} #{team.name}:"
    puts "Points: " + team.ppg.to_s
    puts "Rebounds: " + team.rpg.to_s
    puts "Assists: " + team.apg.to_s
    puts "Turnovers: " + team.topg.to_s
    puts "Steals: " + team.spg.to_s
    puts "-" * 30
    puts "Is there anything else you would like to see?"
    puts "  - Enter 'all' to see complete stats"
    puts "  - Enter 'players' to see a list of this team's players"
    puts "  - Enter 'schedule' to see complete schedule"
    puts "-" * 30

    continue = input
    if continue.downcase == 'all'
      puts " " * 30
      puts "-" * 30
      display_team_stats(team.name)
      prompt
    elsif continue.downcase == "players"
      display_players_by_team(team.name)
      prompt
    elsif continue.downcase == 'schedule'
      display_schedule_by_team(team.name)
      prompt
    end

  else
    # we should enable a way for the user to go 'back' to the last prompt
    puts "Please enter a valid team name."
    team_prompt
  end
  prompt
end

def display_team_stats(team_name)
  team = Team.find_by name: team_name.split(" ").map { |name| name.capitalize }.join(" ")

  puts "Full season stats for the #{team.city} #{team_name}:"
  puts ""

  team.attributes.each do |k, v|
    if v == nil
      puts "#{k}: 0"
    elsif k == "id" || k == "name" || k == "city"
      next
    else
      puts "#{k}: #{v}"
    end
  end
  puts "-" * 30
end

def display_players_by_team(team_name)
  #return a list of every player that belongs to this team
  #query that finds all players where team_name = team_name input
  team_name = team_name.split(" ").map { |name| name.capitalize }.join(" ")
  players = Player.where("team_name = '#{team_name}'")
  puts "Here is a list of players on the #{team_name}"
  puts ""
  players.each { |player| puts player.full_name.split(" ").map{|name| name.capitalize}.join(" ") }
  puts "-" * 30
  puts ""
  prompt
end

def display_schedule_by_team(team)
  puts ""
  schedules = Schedule.where("home_team = '#{team}' OR  away_team = '#{team}'").limit(10)
  puts "Here are the next 10 games that the #{team} will be playing"
  display_schedule(schedules)
  puts ""
  #iterate over the teams and print the schedule
  prompt
end

#-------------------------------------------------------------------------------
def display_nba_image1
str = "            ________
    o      |   __   |
      \_ O |  |__|  |
   ____/ \ |___WW___|
   __/   /     ||
               ||
               ||
_______________||___"

puts str
end

welcome
