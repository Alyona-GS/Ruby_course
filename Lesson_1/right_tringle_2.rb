#The program calculates the type of a triangle

def is_right(arr)
  arr.sort!
  right = arr[2] ** 2 == arr[1] ** 2 + arr[0] ** 2
end

def is_isosceles(arr)
  isosceles = arr[2] == arr[1] || arr[2] == arr[0] || arr[0] == arr[1]
end

def is_equilateral(arr)
  equilateral = arr[0] == arr[1] && arr[1] == arr[2]
end

puts "Введите значения 3 сторон треугольника:"

Sides = []
3.times {Sides.push(gets.chomp.to_i)}

if is_equilateral(Sides)
  puts "Треугольник равносторонний и равнобедренный"
elsif is_right(Sides) && is_isosceles(Sides)
  puts "Треугольник прямоугольный и равнобедренный"
elsif is_right(Sides)
  puts "Треугольник прямоугольный"
elsif is_isosceles(Sides)
  puts "Треугольник равнобедренный"
end