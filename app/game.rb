class Game
  def initialize
    @total_score = 0
  end

  def roll(pins)
     @total_score += pins
  end

  def score
    @total_score
  end
end
