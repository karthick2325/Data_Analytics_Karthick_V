def select_department():
    print("Select Department...:")
    print("1.CSE")
    print("2.IT")
    print("3.AI&DS")
    print("4.ECE")
    print("5.BBA")

    choice=int(input("Choose Your Intersted Department...:"))

    match choice:
        case 1:
            return "Department : Computer Science & Engineering"
        case 2:
            return "Department : Information Technology"
        case 3:
            return "Department : Artificial Intelligence & Data Science"
        case 4:
            return "Department : Electronics & Communication Engineering"
        case 5:
            return "Department : Business Administration"
        case _:
            return "Invalid Department No.."



students={}




def student_reg():

    while True:
        student_id = input("Enter The Student ID : ")

        if student_id in students:
            print("Student Id Already Exist")
            print("Please Enter A Different Student Id")
        else:
            break


    student_name = input("Enter The Student Name : ")


    department = select_department()


    while True:
        year = int(input("Enter Year Of Duration (1 to 4 years) : "))

        if year < 1 or year > 4:
            print("Invalid Year. Enter Year Between 1 and 4")
        else:
            break


    email = input("Enter Your Email : ")


    phone_number = input("Enter Your Phone Number : ")


    while True:
        attendance = float(
            input("Enter The Attendance Percentage (0-100) : ")
        )

        if attendance < 0 or attendance > 100:
            print("Invalid Attendance. Enter Value Between 0 and 100")
        else:
            break


    while True:
        marks = float(input("Enter The Marks (0-100) : "))

        if marks < 0 or marks > 100:
            print("Invalid Mark. Enter Mark Between 0 and 100")
        else:
            break


    while True:
        academic_status = input(
            "Academic Status Is 'Active' or 'Inactive' : "
        )

        if academic_status == "Active" or academic_status == "Inactive":
            break
        else:
            print("Invalid Academic Status. Enter Active or Inactive")


    student_record = {
        "name": student_name,
        "department": department,
        "year": year,
        "email": email,
        "phone no": phone_number,
        "attendance": attendance,
        "marks": marks,
        "courses": set(),
        "academic_status": academic_status
    }


    students[student_id] = student_record


    print("Student Registered Successfully")
    print("Student Id :", student_id)



def student_search():
    student_id=input("Enter The Student ID :")

    if student_id in students:
        student=students[student_id]

        print("Student ID :",student_id)
        print("Student Name :",student["name"])
        print("Department :",student["department"])
        print("Year :",student["year"])
        print("Email :",student["email"])
        print("Phone :",student["phone no"])
        print("Attendance :",student["attendance"])
        print("Academic Status :",student["academic_status"])
        print("Registered Courses :",student["courses"])
    else:
        print("Student Not Found")


def course_reg():
    student_id=input("Enter The Student ID :")

    if student_id not in students:
         print("STUDENT ID NOT FOUND")
         return

    course=input("Enter Course Name :")
    if course in students[student_id]["courses"]:
        print("Course Already Appeared")
    else:
        students[student_id]["courses"].add(course)
        print("Course Registerd Successfully")








while True:

    print("1.Student Registration")
    print("2.Student Search")
    print("3.Course Registration")
    print("4.Attendance")
    print("5.Marks")
    print("6.Result")
    print("7.Department Information")
    print("8.Student Statistics")
    print("9.Student Withdrawal")
    print("10.Exit")

    choice=int(input("Enter Your Choice : "))

    if choice==1:
        student_reg()
    elif choice==2:
        student_search()
    elif choice==3:
        course_reg()
    elif choice==4:
        print("Attendance")