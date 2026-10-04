import pandas as pd

data = {
    "Student_ID": [101, 102, 103, 104, 105],
    "Name": ["Arun", "Priya", "Karthik", "Meena", "Rahul"],
    "Department": ["CSE", "IT", "CSE", "ECE", "IT"],
    "Attendance": [82, 91, 76, 68, 88],
    "Python": [85, 92, 76, 65, 88],
    "SQL": [78, 88, 82, 70, 91],
    "Excel": [90, 95, 80, 72, 86]
}


df=pd.DataFrame(data)

print(df)