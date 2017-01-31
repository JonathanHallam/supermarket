require 'sqlite3'

class Person
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

  def tea_price
    if @basket["FR1"] % 2 == 0
      (@basket["FR1"] / 2) * check_price("FR1")
    else @basket["FR1"] > 1
      ((@basket["FR1"] - 1)/2 * check_price("FR1")) + check_price("FR1")
    end
  end

  def strawberry_price
    if @basket["SR1"] >= 3
      @basket["SR1"] * (check_price("SR1") - 50)
    else @basket["SR1"] * check_price("SR1")
    end
  end

  def basket_total
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

  def check_price(code)
    db = SQLite3::Database.open "supermarket1.db"
    a = db.prepare "SELECT price FROM items WHERE code='#{code}'"
    (a.execute.next.join "\s").to_i
  end

end

class General < Person
  def greeting
    puts "Hello, you're new to our store but that's okay, we still love you."
  end
end

class Employee < Person

  def show_basket(staff_number)
    return "#{@basket} costs: £#{basket_total}"
  end


  def check_name(code)
    db = SQLite3::Database.open "supermarket1.db"
    a = db.prepare "SELECT name FROM employees WHERE staff_number ='#{code}'"
    (a.execute.next.join "\s")
  end

  def greeting(name)
    puts "Greetings #{name}, thank you for your loyal service."
  end

  def check_employment_time(code)
    db = SQLite3::Database.open "supermarket1.db"
    a = db.prepare "SELECT employed_months FROM employees WHERE staff_number ='#{code}'"
    (a.execute.next.join "\s").to_i

  end

  def staff_discount(code)
    return true if check_employment_time(code) >= 6 ; false
  end

  def basket_total(code)

    if staff_discount(code) == true
      (((tea_price + strawberry_price + (@basket["CF1"] * check_price("CF1"))) * 0.9) / 100.00).round(2)
    else
      (tea_price + strawberry_price + (@basket["CF1"] * check_price("CF1"))) / 100.00
    end
  end

end

class Manager < Employee
  def update_price(code, new_price)
      db = SQLite3::Database.open "supermarket1.db"
      db.execute "UPDATE items SET price='#{new_price}' WHERE code='#{code}'"
  end

end

class Loyal_Customer < General

  def check_loyalty(number)
    db = SQLite3::Database.open "supermarket1.db"
    a = db.execute("SELECT '#{number}' FROM loyalty WHERE number = '#{number}'")
    return true if a != [] ; false
  end

  def basket_total(number, code)

    if check_loyalty(number) == true && @basket[code] != 0
      ((tea_price + strawberry_price + (basket["CF1"] * check_price("CF1"))) / 100.00) - ((check_price(code) * 0.05) / 100.00)
    else
      (tea_price + strawberry_price + (@basket["CF1"] * check_price("CF1"))) / 100.00
    end
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
