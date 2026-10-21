class Person:
    def __init__(self,name,email,phone):
        self.name=name
        self.email=email
        self.phone=phone


class Student(Person):
    def __init__(self,name,email,phone,student_id,department,attendance,python_mark,sql_mark,excel_mark):
        super().__init__(name,email,phone)

        self.student_id=student_id
        self.department=department
        self.attendance=attendance
        self.python_mark=python_mark
        self.sql_mark=sql_mark
        self.excel_mark=excel_mark

    def attendance_validate(self):
        if 0<=self.attendance<=100:
            return True
        else:
            return False

    

    


    def total_mark(self):
        return self.python_mark+self.sql_mark+self.excel_mark

    def average_mark(self):
        return self.total_mark()/3

    def grade(self):
        avg=self.average_mark()

        if avg>=80:
            return("Grade A")
        elif avg>=70:
            return("Grade B")
        elif avg>=60:
            return("Grade C")
        elif avg>=50:
            return("Grade D")
        elif avg>=40:
            return("Grade E")
        else:
            return("Grade F")

    def result(self):
        avg=self.average_mark()

        if avg>=50:
            return("Pass")
        else:
            return("Fail")


    def attendance_eligible(self):
        if not self.attendance_validate():
            return "Invalid Attendance"
    
        if self.attendance>=75:
            return "Eligible For Examination"
        else:
            return "Not Eligible For Examination"

    def student_details_show(self):
        print("STUDENT INFORMATION.....")
        print("Student ID :",self.student_id)
        print("Student Name :",self.name)
        print("Student Email :",self.email)
        print("Student Department :",self.department)
        print("Student Attendance :",self.attendance)
        print("Python Mark :",self.python_mark)
        print("SQL Mark :",self.sql_mark)
        print("Excel Mark :",self.excel_mark)
        print("Total Mark :",self.total_mark())
        print("Grade :",self.grade())
        print("Student Result :",self.result())
        print("Attendance Status :",self.attendance_eligible())
        


    


class Faculty(Person):
    def __init__(self,name,email,phone,faculty_id,department,desgination):
        super().__init__(name,email,phone)

        self.department=department
        self.desgination=desgination
        self.faculty_id=faculty_id

    def faculty_details_show(self):
        print("FACULTY INFORMATION.....")
        print("Faculty ID :",self.faculty_id)
        print("Faculty Name :",self.name)
        print("Faculty Email :",self.email)
        print("Faculty Phone :",self.phone)
        print("Faculty Department :",self.department)
        print("Desgination Role :",self.desgination)



students={}
faculties={}


def add_student():
    print("ADD STUDENT...")

    name=input("Enter Student Name :")
    email=input("Enter Student Email :")
    phone=input("Enter Student Phone :")
    student_id=input("Enter The Student ID :")
    department=input("Enter Department Name :")
    attendance=float(input("Enter Attendance Percentage :"))
    python_mark=int(input("Enter Python Mark :"))
    sql_mark=int(input("Enter SQL Mark :"))
    excel_mark=int(input("Enter Excel Mark :"))

    student=Student(name,email,phone,student_id,department,attendance,python_mark,sql_mark,excel_mark)
    if student.attendance_validate():
        students[student_id]=student
        print("Student Added Successfully..")
    else:
        print("Invalid Attendence...")

def view_student():
    print("VIEW STUDENST....")

    for student_id,student in students.items():
        student.student_details_show()
        print()


def check_attendance():
    print("CHECK ATTENDANCE...")

    student_id=input("Enter Your Student ID :")

    if student_id in students:
        student=students[student_id]

        print("Student Name :",student.name)
        print("Attendance :",student.attendance)
        print("Attendance Status :",student.attendance_eligible())

    else:
        print("Student Not Found.....")


def view_result():
    print("VIEW RESULT...")

    student_id=input("Enter The Student ID")

    if student_id in students:
        student=students[student_id]
    
        print("Student Name :",student.name)
        print("Python Mark :",student.python_mark)
        print("SQL Mark :",student.sql_mark)
        print("Excel Mark :",student.excel_mark)
        print("Total Mark :",student.total_mark())
        print("Average Mark :",student.average_mark())
        print("Grade :",student.grade())
        print("Result :",student.result())

    else:
        print("Student Not Found....")




def add_faculty():
    print("ADD FACULTY...")

    name=input("Enter Faculty Name :")
    email=input("Enter Faculty Email :")
    phone=input("Enter Faculty Phone :")
    faculty_id=input("Enter Faculty ID :")
    department=input("Enter Faculty Department :")
    desgination=input("Enter Faculty Role :")

    faculty=Faculty(name,email,phone,faculty_id,department,desgination)
    faculties[faculty_id]=faculty

def view_faculty():
    print("VIEW FACULTY....")

    for faculty_id,faculty in faculties.items():
        faculty.faculty_details_show()
        print()



def main_menu():
    while True:
        print(".....STUDENT MANAGEMENT.....")
        print("1.ADD STUDENTS")
        print("2.VIEW STUDENTS")
        print("3.ADD FACULTY")
        print("4.VIEW FACULTY")
        print("5.CHECK ATTENDANCE")
        print("6.VIEW ACADEMIC RESULT")
        print("7.EXIT")

        choice=int(input("Enter Your Choice :"))

        if choice == 1:
            add_student()
        elif choice == 2:
            view_student()
        elif choice == 3:
            add_faculty()
        elif choice == 4:
            view_faculty()
        elif choice == 5:
            check_attendance()
        elif choice == 6:
            view_result()
        elif choice == 7:
            print("Thank You")
            break
        else:
            print("Invalid Choice..Enter Between 1 To 7...")




main_menu()