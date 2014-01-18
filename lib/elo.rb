class Elo
  attr_accessor :k, :initial, :beta

  def initialize(k=20, initial=1200, beta=200)
    @k = k
    @initial = initial
    @beta = beta
  end
end
