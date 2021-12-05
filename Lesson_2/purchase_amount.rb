#The program outputs the total for the receipt

items = Hash.new

loop do
  puts "Введите имя, цену и количество товара (или стоп, если товаров достаточно):"
  
  input = gets.chomp
  break if input == "стоп"

  name = input.to_sym

  price = gets.chomp.to_f
  amount = gets.chomp.to_f

  #the product is new?
  if items[name].nil?
    
    items[name] = { price => amount }
  else

    if items[name].has_key?(price)
      
      items[name][price] += amount
    else

      items[name][price] = amount
    end
  end
end

puts "Товары: #{items}"

puts "Сумма по каждой товарной позиции:"

sum = 0

items.each_key do |name|

  count = 0
  items[name].each do |price, amount|

    count += price * amount
  end

  puts "#{name} - #{count}"
  sum += count
end

puts "Общая сумма покупок: #{sum}"
