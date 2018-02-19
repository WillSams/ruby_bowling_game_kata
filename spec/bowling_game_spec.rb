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
  end
end
