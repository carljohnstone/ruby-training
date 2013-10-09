describe "Bowling" do
  it "adds up a game with no strikes or spares" do
    game = Game.new( [1] * 20 )
    expect(game.total_score).to eq 20
  end
  
  it "adds on for a spare" do
    game = Game.new( [1, 9] + [1] * 18 )
    expect(game.total_score).to eq 29
  end

end

class Game

  def initialize( scores )
    @scores = scores
  end

  def frames 
    frames = Array.new
    scores = @scores.clone
    (1..10).each do
      frame = Frame.new( scores.shift )
      if frame.score == 10
        bonus1 = scores.shift
        bonus2 = scores.shift
        frame.add_bonus(bonus1 + bonus2)
        scores.unshift(bonus2)
        scores.unshift(bonus1)
      else
        frame.add_bowl(scores.shift)
        if frame.score == 10
          bonus = scores.shift
          frame.add_bonus(bonus)
          scores.unshift(bonus)
        end
      end
      frames.push(frame)
    end
    frames
  end

  def total_score
    frames.reduce(0) { |tot, f| tot + f.score }
  end
end

class Frame

  def initialize( first_bowl )
    @bonus = 0
    @bowls = [first_bowl]
  end

  def add_bowl( bowl )
    @bowls << bowl
  end

  def add_bonus( bonus )
    @bonus += bonus
  end
  
  def score
    @bonus + @bowls.reduce(0) { |tot, bowl| tot += bowl }
  end

end
