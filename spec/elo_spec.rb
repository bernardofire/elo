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

    it 'should calculate new rating' do
      elo = Elo.new
      ra = 1200
      rb = 800
      expect(elo.adjustment(ra, 1, rb)).to eq(1201.8181818181818)
      expect(elo.adjustment(rb, 1, ra)).to eq(818.1818181818181)
      expect(elo.adjustment(ra, 0.5, rb)).to eq(1191.8181818181818)
      expect(elo.adjustment(rb, 0.5, ra)).to eq(808.1818181818181)
      expect(elo.adjustment(rb, 0, ra)).to eq(798.1818181818181)
      expect(elo.adjustment(ra, 0, rb)).to eq(1181.8181818181818)
    end
  end
end
