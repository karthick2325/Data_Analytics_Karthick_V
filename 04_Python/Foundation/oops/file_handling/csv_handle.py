import csv

with open(r"E:\Data_Analytics_Karthick_V\04_Python\Foundation\oops\file_handling\data.csv","w") as file:
    reader=csv.reader(file)
    # for row in file:
    #     print(row)
    # print(file)
    # reader=csv.DictReader(file)
    # for row in reader:
    #     print(row["name"])
    # for row in reader:
    #     print(row["dept"])
    writer=csv.writer(file)
    writer.writerow(["logu","SPY"])
    header_rows=["name","dept"]
    writer=csv.DictWriter(file,fieldnames=header_rows)
    writer.writeheader()
    writer.writerow({"name":"Selvam","dept":"cse"})

    

    

