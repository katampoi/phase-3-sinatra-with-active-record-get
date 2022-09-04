class ApplicationController < Sinatra::Base
  # Add this line to set the Content-Type header for all responses
  set :default_content_type, 'application/json'

  get '/games' do
    # get all the games from the database
    games = Game.all.order(:title).limit(2)
    # Return a JSON response with an array of all the game data
    games.to_json
  end

  # use the :id syntax to create a dynamic route
  get '/games/:id' do
    # look up the game in the database using it's ID
    game = Game.find(params[:id])
    # send a JSON formatted response to the game data
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: {only: [:comment, :score], include: {
        user: { only: [:name]}
      }}
    })

  end

end