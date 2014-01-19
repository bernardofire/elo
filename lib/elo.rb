class Player
  attr_accessor :rating, :games_played, :games

  def initialize
    @config = Configuration.new
    @rating = @config.initial_rating
    @games_played = 0
    @games = []
  end

  def pro_rating?
    @rating >= @config.pro_start
  end
end

class Configuration
  attr_reader :initial_rating, :beginner_start, :pro_start, :k_factor
  def initialize
    @initial_rating = 1000
    @beginner_start = 30
    @pro_start = 2400
    @k_factor = 15
  end
end


