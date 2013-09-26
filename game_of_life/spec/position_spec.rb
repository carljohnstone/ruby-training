require "spec_helper"

describe "Position" do

  it "has a x" do
    p = Position.new(1,1)
    expect(p.x).to eq 1
  end

  it "has a y" do
    p = Position.new(1,1)
    expect(p.y).to eq 1
  end

  it "has neighbours" do
    p = Position.new(1,1)
    expect(p.neighbours.size).to eq 8
  end

  it "has the right neighbours" do
    p = Position.new(1,1)
    expect(p.neighbours).to include Position.new(0,0)
    expect(p.neighbours).to include Position.new(1,0)
    expect(p.neighbours).to include Position.new(2,0)
    expect(p.neighbours).to include Position.new(0,2)
    expect(p.neighbours).to include Position.new(1,2)
    expect(p.neighbours).to include Position.new(2,2)
    expect(p.neighbours).to include Position.new(0,1)
    expect(p.neighbours).to include Position.new(2,1)
  end
end

