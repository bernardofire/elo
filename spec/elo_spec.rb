require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Elo" do
  describe Player do
    it 'should create player with default arguments' do
      p = Player.new
      expect(p.rating).to eq(1200)
      expect(p.games).to eq([])
      expect(p.games_played).to eq(0)
    end
  end

  describe Configuration do
    it 'should create player with default arguments' do
      c = Configuration.new
      expect(c.initial_rating).to eq(1200)
    end
  end
end
