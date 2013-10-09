describe "HPBookSet" do
  it "costs 8EUR for a book" do
    set = HPBookSet.new
    set.add(:book1)
    expect(set.cost).to eq 800
  end

end

describe "Basket" do

  it "costs 8EUR for a book" do
    basket = Basket.new([:book1])
    expect(basket.total).to eq 8
  end

  it "costs 8EUR for 2 copies of the same book" do
    basket = Basket.new([:book1, :book1])
    expect(basket.total).to eq 16
  end
  
  it "has a 5% discount for 2 different books" do
    basket = Basket.new([:book1, :book2])
    expect(basket.total).to eq 15.2
  end

  it "has a 10% discount for 3 different books" do
    basket = Basket.new([:book1, :book2, :book3])
    expect(basket.total).to eq 21.6
  end

  it "has a 20% discount for 4 different books" do
    basket = Basket.new([:book1, :book2, :book3, :book4])
    expect(basket.total).to eq 25.6
  end

  it "has a 25% discount for 5 different books" do
    basket = Basket.new([:book1, :book2, :book3, :book4, :book5])
    expect(basket.total).to eq 30
  end

  it "costs 51.20 for 2 x the first 3 books, and 1 x rest" do
    basket = Basket.new([:book1, :book1, :book2, :book2, :book3, :book3, :book4, :book5])
    expect(basket.total).to eq 51.2
  end

  it "costs 38 for all 5 books plus 1 dupe" do
    basket = Basket.new([:book1, :book2, :book3, :book3, :book4, :book5])
    expect(basket.total).to eq 38
  end

  it "costs 59.20 for 3 x the first 2 books, and 1 x rest" do
    basket = Basket.new([:book1, :book1, :book1, :book2, :book2, :book2, :book3, :book4, :book5])
    expect(basket.total).to eq 51.2
  end

end

class HPBookSet

  def initialize
    @books = Array.new
  end

  def add(book)
    @books.push(book)
  end

  def cost
    case
    when @books.size == 5
      3000
    when @books.size == 4
      2560
    when @books.size == 3
      2160
    when @books.size == 2
      1520
    else
      800
    end
  end
end


class Basket

  def initialize(books)
    @books = books
  end

  def books_hash
    books_hash = Hash.new(0)
    @books.each { |book| books_hash[book] += 1 }
    books_hash
  end

  def sets_needed
    books_hash.values.max
  end

  def sets
    sets = Array.new(sets_needed) { HPBookSet.new }
    books_hash.each do |book, count|
      (0...count).each { |i| sets[i].add(book) }
    end
    sets
  end

  def total
    total = sets.reduce(0) do | tot, set |
      tot += set.cost
    end
    total / 100.00
  end

end

# 1 2 3 3 4 5
# 3 + 3 = 21.60 + 21.60 = 43.20
# 2 + 4 = 15.20 + 25.60 = 40.80
# 1 + 5 =  8.00 + 30.00 = 38.00

# a b c d e a b c
# 4 + 4 = 25.60 + 25.60 = 51.20
# 3 + 5 = 21.60 + 30.00 = 51.60

# a b c a b d a b e
# 5 + 2 + 2 = 30 + 15.2 + 15.2 = 60.40
# 5 + 3 + 1 = 30 + 21.6 + 8 = 59.60
# 4 + 4 + 1 = 25.60 + 25.60 + 8 = 59.20
# 4 + 3 + 2 = 25.60 + 21.60 + 15.2 = 62.40
# 3 + 3 + 3 = 21.6 +21.6 + 21.6 = 64.8


