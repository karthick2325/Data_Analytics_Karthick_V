
# MAP() FUNCTIONS EXAMPLE -1

# prices = [100, 200, 300]

# def discount(x):
#     return x * 0.9

# discounted = list(map(discount, prices))

# print(discounted)








# FILTER() FUNCTIONS EXAMPLE -1

# prices = [200, 750, 450, 1000]

# def check_price(x):
#     return x < 500

# result = list(filter(check_price, prices))

# print(result)








# REDUCE() FUNCTIONS EXAMPLE -1

# from functools import reduce

# prices = [100, 200, 300]

# def add_prices(x, y):
#     return x + y

# total = reduce(add_prices, prices)

# print(total)







# # ALL 3 — One Combined Example

# from functools import reduce

# numbers = [1, 2, 3, 4]

# # map() → change every item
# mapped = list(map(lambda x: x * 2, numbers))
# print(mapped)

# # filter() → select required items
# filtered = list(filter(lambda x: x % 2 == 0, numbers))
# print(filtered)

# # reduce() → combine into one result
# reduced = reduce(lambda x, y: x + y, numbers)
# print(reduced)


