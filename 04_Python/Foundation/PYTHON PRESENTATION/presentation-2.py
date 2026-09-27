# 1. Add 5 marks to every student
marks = [40, 50, 60, 70]
result = list(map(lambda x: x + 5, marks))
print(result)


# 2. Increase every price by 10%
prices = [100, 200, 300]
result = list(map(lambda x: x * 1.10, prices))
print(result)


# 3. Find only even numbers
numbers = [1, 2, 3, 4, 5, 6]
result = list(filter(lambda x: x % 2 == 0, numbers))
print(result)


# 4. Select employees above 18
ages = [15, 20, 17, 25, 30]
result = list(filter(lambda x: x > 18, ages))
print(result)


# 5. Calculate the total
from functools import reduce
numbers = [10, 20, 30, 40]
result = reduce(lambda x, y: x + y, numbers)
print(result)


# 6. Find the final shopping total
prices = [100, 200, 300]
result = reduce(lambda x, y: x + y, prices)
print(result)


# 7. Convert Celsius to Fahrenheit
celsius = [0, 20, 30, 40]
result = list(map(lambda x: (x * 9 / 5) + 32, celsius))
print(result)


# 8. Select marks 50 or above
marks = [35, 55, 70, 40, 80]
result = list(filter(lambda x: x >= 50, marks))
print(result)


# 9. Multiply all numbers together
numbers = [2, 3, 4]
result = reduce(lambda x, y: x * y, numbers)
print(result)


# 10. Convert every name to uppercase
names = ["karthick", "Kannan", "Krishnan"]
result = list(map(lambda x: x.upper(), names))
print(result)


