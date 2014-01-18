require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Elo" do
  describe Elo do
    it 'should create Elo with default arguments' do
      elo = Elo.new
      expect(elo.k).to eq(20)
      expect(elo.initial).to eq(1200)
      expect(elo.beta).to eq(200)
    end
  end
end
