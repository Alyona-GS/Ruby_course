#the program fills the array with Fibonacci numbers up to 100

arr = [0, 1]
i = 1

loop do
  sum = arr[i] + arr[i-1]
  break if sum >= 100

  arr[i + 1] = sum
  i += 1
end