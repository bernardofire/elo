require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Elo" do
  describe Elo do
    it 'should create Elo with default arguments' do
      elo = Elo.new
      expect(elo.k).to eq(20)
      expect(elo.initial).to eq(1200)
      expect(elo.beta).to eq(200)
    end

    it 'should calculate the right expectation' do
      elo = Elo.new
      ra = 1200
      rb = 800
      expect(elo.expect(ra, rb)).to eq(0.9090909090909091)
      expect(elo.expect(rb, ra)).to eq(0.09090909090909091)
    end
  end
end
