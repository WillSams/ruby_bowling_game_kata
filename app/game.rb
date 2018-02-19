class Game
  def initialize
    @rolls = Array.new(21, 0)
    @current_roll = 0
  end

  def roll(pins)
    @rolls[@current_roll] = pins
    @current_roll += 1
  end

  def score
    total_score = 0
    frame_index = 0

    10.times do  #10 frames
      if strike?(frame_index)
        total_score += strike_bonus(frame_index)
        frame_index += 1
      elsif spare?(frame_index)
        total_score += spare_bonus(frame_index)
        frame_index +=2
      else
        total_score += sum_of_pins_down_in_frame(frame_index)
        frame_index += 2
      end
    end
    total_score
  end

  private
    def spare?(frame_index)
      @rolls[frame_index] + @rolls[frame_index + 1] == 10
    end

    def strike?(frame_index)
      @rolls[frame_index] == 10
    end

    def spare_bonus(frame_index)
      10 + @rolls[frame_index + 2]
    end

    def strike_bonus(frame_index)
      10 + @rolls[frame_index+1] + @rolls[frame_index+2]
    end

    def sum_of_pins_down_in_frame(frame_index)
      @rolls[frame_index] + @rolls[frame_index + 1]
    end
end
