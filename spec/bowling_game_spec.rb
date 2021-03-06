require 'spec_helper'
require_relative '../app/game'

describe Game do

  before :each do
    @game = Game.new
  end

  describe "#new" do
    it "takes 0 parameters and returns a Game object" do
      expect(@game).to be_an_instance_of Game
    end
  end

  describe "#roll" do
    it "bowler rolled a straight gutter game" do
      20.times { @game.roll(0) }
      expect(@game.score).to equal 0
    end

    it "bowler knocked down 1 pin each roll" do
      20.times { @game.roll(1) }
      expect(@game.score).to equal 20
    end

    it "bowler only rolled a spare plus 3" do
      @game.roll(5)
      @game.roll(5)               #spare strike!
      @game.roll(3)
      17.times { @game.roll(0)}   #other 17 rolls were duds
      expect(@game.score).to equal 16
    end

    it "bowler only rolled a spare plus 3 in a middle frame" do
      8.times { @game.roll(0)}    #bowler start the game on a 10 roll gutter streak!
      @game.roll(5)
      @game.roll(5)               #spare strike!
      @game.roll(3)
      9.times { @game.roll(0)}   #bowler ended game much like how he/she started....terri-bad
      expect(@game.score).to equal 16
    end

    it "bowlers rolled a strike, then x and xx" do
      @game.roll(10)
      @game.roll(3)
      @game.roll(4)
      17.times { @game.roll(0)}
      expect(@game.score).to equal 24
    end

    it "bowlers rolled a strike, then x and xx in middle frames" do
      8.times { @game.roll(0)}    #bowler start the game on a 10 roll gutter streak!
      @game.roll(10)
      @game.roll(3)
      @game.roll(4)
      9.times { @game.roll(0)}   #bowler ended game much like how he/she started....terri-bad
      expect(@game.score).to equal 24
    end

    it "bowler rolled a perfect game" do
      20.times { @game.roll(10)}
      expect(@game.score).to equal 300
    end

    it "bowler rolled a perfect game" do
      20.times { @game.roll(10)}
      expect(@game.score).to equal 300
    end
  end
end
