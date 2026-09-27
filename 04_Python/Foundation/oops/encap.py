class student:

    def __init__(self, name, id, department, marks):
        self.name = name
        self.id = id
        self.department = department
        self.__marks = marks
        self.attendance = 0
        self.average = 0

        self.set_marks(marks)
        self.get_avg()

    def set_marks(self, marks):

        for mark in marks:
            if mark < 0 or mark > 100:
                print("Invalid Marks. Write Between 0 To 100")
                return False

        return True

    def get_avg(self):

        self.average = sum(self.__marks) / len(self.__marks)

        return self.average

    def get_grade(self):

        if self.average >= 90:
            return "A"
        elif self.average >= 80:
            return "B"
        elif self.average >= 70:
            return "C"
        elif self.average >= 60:
            return "D"
        elif self.average >= 40:
            return "E"
        else:
            return "F"


std1 = student("Karthick", "2322K0081", "CS", [75, 80, 90])

print("Name:", std1.name)
print("ID:", std1.id)
print("Department:", std1.department)
print("Average:", std1.get_avg())
print("Grade:", std1.get_grade())