#The program calculates the type of a triangle 

puts "Введите значения 3 сторон треугольника:"

a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

if a == b && a == c
  equilateral = true
end

if a == b || b == c || a == c
  isosceles = true
end

if (c ** 2 == a ** 2 + b ** 2) || (a ** 2 == b ** 2 + c ** 2) || (b ** 2 == a ** 2 + c ** 2)
  right = true
end

puts "Треугольник: #{"равносторонний " if equilateral}#{"равнобедренный " if isosceles}#{"прямоугольный" if right}"