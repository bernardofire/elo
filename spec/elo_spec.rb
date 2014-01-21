require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Elo" do
  describe Rating do
    before(:each) do
      @p1 = Player.new
      @p2 = Player.new
      @rating = Rating.new(@p1, @p2)
    end

    it 'winner' do
      expect(@rating.winner).to eq 1010.000
    end

    it 'loser' do
      expect(@rating.loser).to eq 990.000
    end

    it 'expected' do
      expected_p1 = @rating.expected(@p1, @p2)
      expect(expected_p1).to eq(0.5)
      expected_p2 = @rating.expected(@p2, @p1)
      expect(expected_p2).to eq(0.5)

      @p1.rating = 1400
      @p2.rating = 800

      expected_p1 = @rating.expected(@p2, @p1)
      expect(expected_p1.to_s[0..3].to_f).to eq(0.96)
      expected_p2 = @rating.expected(@p1, @p2)
      expect(expected_p2.to_s[0..3].to_f).to eq(0.03)
    end
  end
  describe Player do
    it 'should create player with default arguments' do
      p = Player.new
      expect(p.rating).to eq(1000)
      expect(p.games).to eq([])
    end

    it 'k_factor' do
      expect(Player.new.k_factor).to eq(20)
    end

    it 'win' do
      player = Player.new
      opponent = Player.new
      player.wins_from opponent
      expect(player.rating).to eq(1010.000)
      expect(opponent.rating).to eq(990.000)
    end

    it 'lose' do
      player = Player.new
      opponent = Player.new
      player.loses_to opponent
      expect(player.rating).to eq(990.000)
      expect(opponent.rating).to eq(1010.000)
    end

    it 'beginner?' do
      p = Player.new
      expect(p.beginner?).to eq(true)
      p.rating = 2400
      expect(p.beginner?).to eq(false)
    end

    it 'pro?' do
      p = Player.new
      expect(p.pro?).to eq(false)
      p.rating = 2400
      expect(p.pro?).to eq(true)
      p.rating = 2500
      expect(p.pro?).to eq(true)
    end
  end

  #describe Game do
  #  it '' do
  #  end
  #end

  describe Configuration do
    it 'should create configuration with default arguments' do
      c = Configuration.new
      expect(c.initial_rating).to eq(1000)
      expect(c.beginner_start).to eq(30)
      expect(c.pro_start).to eq(2400)
      expect(c.k_factor).to eq(20)
    end
  end
end
