require_relative 'config/environment'

def welcome
  puts "Welcome to the NBA stat tracker!"
end

def prompt
  puts "What are you interested in?"
  puts "---------------------------"
  puts "Press 1 for Player stats"
  puts "Press 2 for Team stats"
  puts "Press 3 for Schedules"
  puts "---------------------------"

  input
end

def input
  gets.chomp
end

def user_input(val)
  if val == "1"
    # display player prompt
  elsif val == "2"
    # display team prompt
  elsif val == "3"
    # display schedule prompt
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
