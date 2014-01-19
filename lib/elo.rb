class Elo
  attr_accessor :k, :initial, :beta

  def initialize(k=20, initial=1200, beta=200)
    @k = k
    @initial = initial
    @beta = beta
  end

  def expect(player, opponent)
    diff = opponent.to_f - player.to_f
    f_factor = 2 * @beta
    1.to_f / (1 + 10 ** (diff / f_factor))
  end
end
