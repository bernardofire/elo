class Player
  attr_accessor :rating, :games_played, :games

  def initialize
    @rating = 1200
    @games_played = 0
    @games = []
  end
end
