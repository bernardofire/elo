class Player
  attr_accessor :rating, :games_played, :games

  def initialize
    @config = Configuration.new
    @rating = @config.initial_rating
    @games = []
  end

  def beginner?
    @rating < @config.pro_start
  end

  def pro?
    !beginner?
  end

  def k_factor
    @config.k_factor
  end
end

class Configuration
  attr_accessor :initial_rating, :beginner_start, :pro_start, :k_factor

  def initialize
    @initial_rating = 1000
    @beginner_start = 30
    @pro_start = 2400
    @k_factor = 15
  end
end


