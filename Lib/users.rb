require './basket.rb'

class General < Basket
  def greeting
    puts "Hello, you're new to our store but that's okay, we still love you."
  end
end

class Employee < Basket
  def check_name
    require 'sqlite3'
    begin
      db = SQLite3::Database.open "supermarket.db"
      a = db.prepare "SELECT name FROM employees WHERE code='#{code}'"
      (a.execute.next.join "\s").to_i
    end
  end

  # 10% off after 6 months
  # The database stuff is lost on me for the moment
  # 31
end

class Manager < Employee
  # Can update prices
end

class Loyal_Customer < Basket
  # Gets 5% off a selected product
end
