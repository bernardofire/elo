class Player
  attr_accessor :rating, :games_played, :games

  def initialize
    @config = Configuration.new
    @rating = @config.initial_rating
    @games = []
  end

  def versus(winner, loser, tie=false)
    game = Game.new(winner, loser, tie)
    game.finish
  end

  def ties_with(opponent)
    versus(self, opponent, true)
  end

  def wins_from(opponent)
    versus(self, opponent)
  end

  def loses_to(opponent)
    versus(opponent, self)
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

class Game
  attr_accessor :winner, :loser, :result

  def initialize(winner, loser, tie=false)
    @winner = winner
    @loser = loser
    @tie = tie
  end

  def finish
    update_played_games
    update_players_ratings
  end

  def tie?
    @tie
  end

  def update_players_ratings
    new_ratings = Rating.new(winner, loser, @tie).new_ratings
    @winner.rating = new_ratings[@winner]
    @loser.rating = new_ratings[@loser]
  end

  def update_played_games
    @winner.games << self
    @loser.games << self
  end
end

class Rating
  attr_accessor :winner, :loser

  def initialize(winner, loser, tie=false)
    @winner = winner
    @loser = loser
    @tie = tie
  end

  def new_ratings
    { @winner => winner,
      @loser => loser }
  end

  def expected(first, second)
    1.0 / ( 1.0 + ( 10.0 ** ( ( first.rating - second.rating ) / 400.0 ) ) )
  end

  def winner
    result = (@tie && 0.5) || 1.0
    @winner.rating + @winner.k_factor.to_f * ( result - expected(@loser, @winner) )
  end

  def loser
    result = (@tie && 0.5) || 0.0
    @loser.rating + @loser.k_factor.to_f * ( result - expected(@winner, @loser) )
  end
end

class Configuration
  attr_accessor :initial_rating, :beginner_start, :pro_start, :k_factor

  def initialize
    @initial_rating = 1000
    @beginner_start = 30
    @pro_start = 2400
    @k_factor = 20
  end
end
