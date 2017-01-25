require 'basket'

describe Basket do
  it "Opens a new basket, can add an item to it and calulate price" do
    x = start_checkout
    x.add("FR1")
    expect(x.show_basket).to eq('{"FR1"=>1, "SR1"=>0, "CF1"=>0} costs: £3.11')
  end

  it "Opens a new basket, adds some items, removes others and calculates price" do
    x = start_checkout
    x.add("FR1")
    x.add("FR1")
    x.add("SR1")
    x.remove("FR1")
    expect(x.show_basket).to eq('{"FR1"=>1, "SR1"=>1, "CF1"=>0} costs: £8.11')
  end

  it "Opens a new basket, adds stuff, removes stuff, checks out and empties basket" do
    x = start_checkout
    x.add("FR1")
    x.add("FR1")
    x.add("SR1")
    x.remove("FR1")
    expect(x.complete_purchase).to eq('That cost £8.11 and your basket is now empty')
  end

  it "Applies the two for one offer on two or more youghurts" do
    x = start_checkout
    x.add("FR1")
    x.add("FR1")
    x.add("FR1")
    expect(x.basket_total).to eq(6.22)
  end

  it "Applies the 50p discount to strawberries if you buy 3 or more" do
    x = start_checkout
    x.add("SR1")
    x.add("SR1")
    x.add("SR1")
    x.add("SR1")
    expect(x.basket_total).to eq(18.00)
  end

  it "doesn't if you only buy 2" do
    x = start_checkout
    x.add("SR1")
    x.add("SR1")
    expect(x.basket_total).to eq(10.00)
  end

  it "does the above two things in combination" do
    x = start_checkout
    x.add("FR1")
    x.add("SR1")
    x.add("FR1")
    x.add("SR1")
    x.add("SR1")
    expect(x.basket_total).to eq(16.61)

  end



end
