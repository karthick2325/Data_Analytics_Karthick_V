while True:

    mark=int(input("Enter Your Mark :"))

    if mark>=90:
        print("Grade : O")
    elif mark>=80:
        print("Grade : A")
    elif mark>=70:
        print("Grade : B")
    elif mark>=60:
        print("Grade : C")
    elif mark>=40:
        print("Grade : D")
    elif mark<40 and mark>0:
        print("Fail/RA")
    else:
        print("Enter The Correct mark between the 0 - 100")