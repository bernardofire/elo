class Player
  attr_accessor :rating, :games_played, :games

  def initialize
    @rating = 1200
    @games_played = 0
    @games = []
  end
end

class Configuration
  attr_reader :initial_rating
  def initialize
    @initial_rating = 1200
  end
end
