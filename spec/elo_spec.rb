require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Elo" do
  describe Player do
    it 'should create player with default arguments' do
      p = Player.new
      expect(p.rating).to eq(1000)
      expect(p.games).to eq([])
    end

    it 'k_factor' do
      expect(Player.new.k_factor).to eq(20)
    end

    it 'beginner' do
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

  describe Configuration do
    it 'should create configuration with default arguments' do
      c = Configuration.new
      expect(c.initial_rating).to eq(1000)
      expect(c.beginner_start).to eq(30)
      expect(c.pro_start).to eq(2400)
      expect(c.k_factor).to eq(15)
    end
  end
end
