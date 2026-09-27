print("STUDENT PORTAL")


student_id=input("Enter Student Id :")
student_name=input("Enter Student Name :")

while student_id=="" or student_name=="":
    print("Empty Value Not Accept...")

    student_id=input("Enter Student Id :")
    student_name=input("Enter Student Name :")

print()
print("Student ID :",student_id)
print("Student Name :",student_name)
print()

while True:
    print("....STUDENT SERVICES....")
    print("1.CHECK ELIGIBILITY FOR EXAM")
    print("2.CHECK RESULT AND GRADE")
    print("3.SELECT DEPARTMENT")
    print("4.EXIT")
    print()

    choice=int(input("Enter Your Choice No :"))

    match choice:
        case 1:
            attendence_percentage=float(input("Enter Your Attendence Percentage :"))
            if attendence_percentage<0 or attendence_percentage>100:
                print("Enter Valid Attendence Percentage")
                choice=int(input("Enter Your Choice No :"))
            elif attendence_percentage>=75:
                print("Eligible For Exam..")
            else:
                print("Not Eligible For Exam...")
            print()

        case 2:
            mark=float(input("Enter Your Mark :"))

            if mark<0 or mark>100:
                print("Enter The Valid Mark..")
                choice=int(input("Enter Your Choice No :"))
            if mark>=40:
                print("Result Is Pass")
            else:
                print("Result Is Fail")

            if mark>=90:
                print("Grade : A")
            elif mark>=80:
                print("Grade : B")
            elif mark>=70:
                print("Grade : C")
            elif mark>=60:
                print("Grade : D")
            elif mark>=50:
                print("Grade : E")
            else:
                print("Grade : F")
            print()
        case 3:
            print("Select Department...:")
            print("1.CSE")
            print("2.IT")
            print("3.AI&DS")
            print("4.ECE")
            print("5.BBA")

            choice=int(input("Choose Your Intersted Department...:"))

            match choice:
                case 1:
                    print("Department : Computer Science & Engineering")
                case 2:
                    print("Department : Information Technology")
                case 3:
                    print("Department : Artificial Intelligence & Data Science")
                case 4:
                    print("Department : Electronics & Communication Engineering")
                case 5:
                    print("Department : Business Administration")
                case _:
                    print("Invalid Department No..")
            print()

        case 4:
            print("Welcome")
            break

        case _:
            print("Invalid Choice.Enter Valid Choice...")
            continue
    print()

print("Application Succuessfully Runned....")




                



        
