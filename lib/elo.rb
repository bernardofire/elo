class Elo
  attr_accessor :k, :initial, :beta

  def initialize(k=20, initial=1200, beta=200)
    @k = k
    @initial = initial
    @beta = beta
  end

  def expect(rate, other_rate)
    diff = other_rate.to_f - rate.to_f
    f_factor = 2 * @beta
    1.to_f / (1 + 10 ** (diff / f_factor))
  end
end
