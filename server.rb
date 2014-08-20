require 'sinatra'
# require 'sinatra/reloader'
require 'csv'
require "pry"

team_data = []


CSV.foreach('team_data.csv', headers: true, header_converters: :symbol) do |row|
  team_data << row.to_hash
end

def team_gen(team_data)
  teams=[]
  team_data.each do |team|
    teams << team[:team]
  end
  teams
end

# WHere is this going to go?
# Hom. so the "index" file
# will come to the current get request
get '/' do
  @teams = team_gen(team_data).uniq
  erb :index
end

get '/:team_name' do
  @players = team_data.reject{ |player| player[:team]!= params['team_name']}
  erb :team
end
