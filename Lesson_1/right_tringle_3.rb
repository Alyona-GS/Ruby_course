#The program calculates the type of a triangle

puts "Введите значения 3 сторон треугольника:"

Sides = []
3.times {Sides.push(gets.chomp.to_i)}

Sides.sort!
right = Sides[2] ** 2 == Sides[1] ** 2 + Sides[0] ** 2
isosceles = Sides[2] == Sides[1] || Sides[2] == Sides[0] || Sides[0] == Sides[1]
equilateral = Sides[0] == Sides[1] && Sides[1] == Sides[2]

if equilateral
  puts "Треугольник равносторонний и равнобедренный"
elsif right && isosceles
  puts "Треугольник прямоугольный и равнобедренный"
elsif right
  puts "Треугольник прямоугольный"
elsif isosceles
  puts "Треугольник равнобедренный"
end