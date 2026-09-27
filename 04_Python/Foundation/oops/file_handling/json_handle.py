import json

with open(r"E:\Data_Analytics_Karthick_V\04_Python\Foundation\oops\file_handling\std_data.json","r") as j_file:
    student=json.load(j_file)
    json.dumps(student)


print(student["marks"]["SQL"])

