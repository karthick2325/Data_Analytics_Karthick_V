def average_mark(self):
    self.average=sum(self.marks)/len(self.marks)
    return self.average

class student:
    def __init__(self,name,id,dept,marks):
        self.name=name
        self.id=id
        self.dept=dept
        self.marks=average_mark(self)
        self.attendance=0
    




std1=student("Karthick","2322K0081","CS",[80,90,98])
std2=student("Kannan","2322K0082","CS",[40,70,87])

print(std1.name)
print(std1.id)
print(std1.dept)
print(std1.marks)
print(std1.attendance)


print(std2.name)
print(std2.id)
print(std2.dept)
print(std2.marks)
print(std2.attendance)