require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Elo" do
  describe Rating do
    before(:each) do
      @p1 = Player.new
      @p2 = Player.new
      @rating = Rating.new(@p1, @p2)
    end

    it 'new_ratings' do
      new = @rating.new_ratings
      expect(new.class).to eq Hash
      expect(new[@p1]).to eq 1010.000
      expect(new[@p2]).to eq 990.000
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
    it 'create player' do
      p = Player.new
      expect(p.rating).to eq(1000)
      expect(p.games).to eq([])
    end

    it 'k_factor' do
      expect(Player.new.k_factor).to eq(20)
    end

    it 'wins_from' do
      player = Player.new
      opponent = Player.new
      player.wins_from opponent
      expect(player.rating).to eq(1010.000)
      expect(opponent.rating).to eq(990.000)
    end

    it 'loses_to' do
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

  describe Game do
    before :each do
      @winner = Player.new
      @loser = Player.new
      @game = Game.new @winner, @loser
    end

    it 'create' do
      expect(@game.winner).to eq @winner
      expect(@game.loser).to eq @loser
    end

    describe 'tie' do
      @player_1 = Player.new
      @player_2 = Player.new

      it 'create' do
        game = Game.new @player_1, @player_2, true
        tie = game.instance_eval { @tie }
        expect(tie).to eq true
      end

      it 'tie?' do
        game = Game.new @player_1, @player_2, true
        expect(game.tie?).to eq true
      end

      it 'update_players_ratings' do
      @player_1 = Player.new; @player_2 = Player.new
      game = Game.new @player_1, @player_2, true

      expect(@player_1.rating).to eq 1000
      expect(@player_2.rating).to eq 1000

      game.update_players_ratings

      expect(@player_1.rating).to eq 1000.000
      expect(@player_2.rating).to eq 1000.000
      end
    end

    it 'update_played_games' do
      expect(@winner.games.size).to eq 0
      expect(@loser.games.size).to eq 0

      @game.update_played_games

      expect(@winner.games.size).to eq 1
      expect(@winner.games.first).to eq @game

      expect(@loser.games.size).to eq 1
      expect(@loser.games.first).to eq @game
    end

    it 'update_players_ratings' do
      expect(@winner.rating).to eq 1000
      expect(@loser.rating).to eq 1000

      @game.update_players_ratings

      expect(@winner.rating).to eq 1010.000
      expect(@loser.rating).to eq 990.000
    end
  end

  describe Configuration do
    it 'create' do
      c = Configuration.new
      expect(c.initial_rating).to eq(1000)
      expect(c.beginner_start).to eq(30)
      expect(c.pro_start).to eq(2400)
      expect(c.k_factor).to eq(20)
    end
  end
end
