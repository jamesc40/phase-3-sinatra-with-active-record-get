class ApplicationController < Sinatra::Base
  
  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end
  
  get '/games' do 
    # get's all the games from the db then returns them as JSON 
    Game.all.order(:title).limit(10).to_json
  end

  get '/games/:id' do
    # finds the game with the id provided from params and returns it as JSON
    # Game.find(params[:id]).to_json(include: {reviews: { include: :user } })
    game = Game.find(params[:id])
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      }}
    })
  end
end
