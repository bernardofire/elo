class Player
  attr_accessor :rating, :games_played, :games

  def initialize
    @config = Configuration.new
    @rating = @config.initial_rating
    @games = []
  end

  def versus(winner, loser)
    game = Game.new(winner, loser)
    game.update_played_games
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

  def initialize(winner, loser)
    @winner = winner
    @loser = loser
  end

  def finish
    update_players_ratings
    update_played_games
  end

  #def draw?
  #end

  def update_players_ratings
    new_ratings = Ratings.new(winner, loser).new_ratings
    @winner.rating = new_ratings[:winner]
    @loser.rating = new_ratings[:loser]
  end

  #def result=(result)
  #  @result = result
  #  update
  #end

  def update_played_games
    @winner.games << self
    @loser.games << self
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

class Ratings
  attr_accessor :winner, :loser

  def initialize(winner, loser)
    @winner = winner
    @loser = loser
  end

  def new_ratings
    { @winner => winner,
      @loser => loser }
  end

  def loser
    new_loser_rating
  end

  def winner
    new_winner_rating
  end

  def expected(first, second)
    1.0 / ( 1.0 + ( 10.0 ** ( ( first.rating - second.rating ) / 400.0 ) ) )
  end

  def new_winner_rating
    @winner.k_factor.to_f * ( 1.0 - expected(@loser, @winner) )
  end

  def new_loser_rating
    @loser.k_factor.to_f * ( 0.0 - expected(@winner, @loser) )
  end
end
