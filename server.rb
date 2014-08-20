### REQUIREMENTS ###

require 'sinatra'
require 'sinatra/reloader'
require 'csv'
require "pry"


### GET INFORMATION ###
team_data = []

CSV.foreach('team_data.csv', headers: true, header_converters: :symbol) do |row|
  team_data << row.to_hash
end


## METHODS ##
#
def team_gen(team_data)
  teams=[]
  team_data.each do |team|
    teams << team[:team]
  end
  teams.uniq
end

def get_position(team_data)
  position = []
  team_data.each do |team|
    position << team[:position]
  end
  position.uniq
end

### GET REQUESTS  ###

get '/' do
  @position = get_position(team_data)
  @team_data = team_data
  @teams = team_gen(team_data)
  erb :index
end

get '/:team_name' do
  @players = team_data.reject{ |player| player[:team]!= params['team_name']}
  erb :team
end

get '/allplayers/:position' do
  @position = params[:position]
  @players = team_data.select { |player| player[:position] == params[:position]}
  erb :by_position
end













