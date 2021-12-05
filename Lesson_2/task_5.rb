#The programs outputs the number of days since the beginning of the year

days_in_months = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

puts "Введите число, месяц и год"

a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

if c % 4 == 0
  days_in_months[1] = 29
end

counter = a
for i in 0..b-2
  counter += days_in_months[i]
end

puts counter