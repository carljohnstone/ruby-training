describe "Bowling" do
  it "adds up a game with no strikes or spares" do
    game = Game.new( [1] * 20 )
    expect(game.total_score).to eq 20
  end
  
  it "adds on for a spare" do
    game = Game.new( [1, 9] + [1] * 18 )
    expect(game.total_score).to eq 29
  end

  it "adds on for a strike" do
    game = Game.new( [10] + [1] * 18 )
    expect(game.total_score).to eq 30
  end

  it "adds on for a double strike" do
    game = Game.new( [10, 10] + [1] * 16 )
    expect(game.total_score).to eq 49
  end

  it "adds on for a turkey" do
    game = Game.new( [10, 10, 10] + [1] * 14 )
    expect(game.total_score).to eq 77
  end

  it "deals with a strike in the last frame" do
    game = Game.new( [1] * 18 + [10, 1, 1] )
    expect(game.total_score).to eq 30
  end

  it "deals with a spare in the last frame" do
    game = Game.new( [1] * 18 + [1,9,1] )
    expect(game.total_score).to eq 29
  end

  it "deals with a turkey in the last frame" do
    game = Game.new( [1] * 18 + [10, 10, 10] )
    expect(game.total_score).to eq 48
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
        frame.add_bonus(scores[0] + scores[1])
      else
        frame.add_bowl(scores.shift)
        if frame.score == 10
          frame.add_bonus(scores[0])
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
