require './users'

class Basket

  attr_accessor :basket
  def initialize
    @basket = { "FR1" => 0,
                "SR1" => 0,
                "CF1" => 0,
    }
  end

  def show_basket
    return "#{@basket} costs: £#{basket_total}"
  end



  def basket_total

    def tea_price
      if @basket["FR1"] > 1 && @basket["FR1"] % 2 == 0
        (@basket["FR1"] / 2) * check_price("FR1")
      elsif @basket["FR1"] > 1
        ((@basket["FR1"] - 1)/2 * check_price("FR1")) + check_price("FR1")
      elsif @basket["FR1"] <= 1
        @basket["FR1"] * check_price("FR1")
      end
    end

    def strawberry_price
      if @basket["SR1"] >= 3
        @basket["SR1"] * (check_price("SR1") - 50)
      else @basket["SR1"] * check_price("SR1")
      end
    end


    (tea_price + strawberry_price + (@basket["CF1"] * check_price("CF1"))) / 100.00
  end

  def add(x)
    @basket[x] = @basket[x] + 1
  end

  def remove(x)
    @basket[x] = @basket[x] - 1 if @basket[x] > 0
  end

  def complete_purchase
    running_price = basket_total
    @basket = { "FR1" => 0,
                "SR1" => 0,
                "CF1" => 0,
    }
    return "That cost £#{running_price} and your basket is now empty"

  end

end

def start_checkout
  General.new
end

def start_employee
  Employee.new
end

def start_manager
  Manager.new
end

def start_loyal
  Loyal_Customer.new
end

def check_price(code)
  require 'sqlite3'
  begin
    db = SQLite3::Database.open "supermarket.db"
    a = db.prepare "SELECT price FROM items WHERE code='#{code}'"
    (a.execute.next.join "\s").to_i
  end

end
