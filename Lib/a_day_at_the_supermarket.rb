require './Lib/basket.rb'

puts "Hello, do you have a staff number?"
puts "Y N"
print ">"
sn_response = $stdin.gets.chomp.upcase
if sn_response == "Y"
  puts "Enter staff number"
  print ">"
  staff_number = $stdin.gets.chomp
  x = start_employee
  name = x.check_name(staff_number)
  puts x.greeting(name)

# Check staff number


elsif sn_response == "N"
  puts "Do you have a loyalty card number?"
  puts "Y N"
  print ">"
  lc_response = $stdin.gets.chomp.upcase
  if lc_response == "Y"
    puts "Enter your loyalty card number now"
    loyalty_number = $stdin.gets.chomp

    x = start_loyal

  elsif lc_response == "N"
    x = start_checkout
    puts x.greeting
  end
end


  puts "What would you like to do?"
  puts "add, remove, running total or checkout?"
  print ">"
  choice = $stdin.gets.chomp.downcase
  if choice == "add"
    puts "add what? FR1 SR1 CF1"
    print ">"
    product = $stdin.gets.chomp.upcase
    x.add(product)

end
