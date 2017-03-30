require_relative '../config/environment'

def welcome
  puts "Welcome to the NBA stat tracker!"
  prompt
end

def prompt
  puts "What are you interested in?"
  puts "---------------------------"
  puts "Press 1 for Player stats"
  puts "Press 2 for Team stats"
  puts "Press 3 for Schedules"
  puts "---------------------------"
  user_input(input)
end

def input
  gets.chomp
end

def user_input(val)
  if val == "1"
    # display player prompt
    puts "player prompt will go here"
  elsif val == "2"
    # display team prompt
    puts "team prompt will go here"
  elsif val == "3"
    # display schedule prompt
    puts "schedule prompt will go here"
  else
    # inform invalid option
  end
end

def player_prompt
  puts "Select the player you are looking for."
  input

  # if player iexists in db
    # return more/return player
  #else
    # inform player not exists
end

def team_prompt
  puts "Select the team you are looking for."
  input

  # if team exists
    # team
  # else
    # inform does not exist
end

def schedule_prompt
  # a range of dates would be nice
  puts "Select the day you are looking for"
  input

  # if date
    # list games on that date
  # else
    # inform no dates/invalid date
end

def top_ten
  #select all players, order by points, limit(10)
  players = Player.all.order('total_pts DESC LIMIT(10)')
  puts "top ten players by points"
  puts "------------------------------------------------------------------------"
  players.each do |player|
    puts player.first_name + " " + player.last_name + " | " + player.total_pts.to_s
  end
  puts "------------------------------------------------------------------------"
end

def stats_player(name)
  player = Player.find_by full_name: name
end

welcome
