#The program calculates the quadratic equation

puts "Введите значения 3 коэффициентов a, b, c (строго по порядку):"

a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

D = b ** 2 - 4 * a * c

if D == 0 || D > 0

  x1 = (b * (-1) + Math.sqrt(D)) / (2 * a)
  x2 = (b * (-1) - Math.sqrt(D)) / (2 * a)

  if x1 == x2
    puts "D = #{D}, корень уравнения: #{x1}"
  else
    puts "D = #{D}, корни уравнения: #{x1}, #{x2}"
  end

else
  puts "D = #{D}, корней нет"
end