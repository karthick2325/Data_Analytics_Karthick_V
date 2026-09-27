# try:
#     age=int(input("Enter Your Age :"))
#     print(age)

#     #INPUT-20
#     #OUTPUT-20

#     #INPUT-twenty
#     #OUTPUT-ValueError: invalid literal for int() with base 10: 'twenty'

# except ValueError:
#     print("Enter The Integer Value Only")


try:
    file=open("test.txt","r")
    print(file.read())
    # file=open(r"E:\Data_Analytics_Karthick_V\04_Python\Foundation\oops\file_handling\test.txt","r")
    # print(file.read())

except FileNotFoundError :
    print("File Not Found .First Create Then Open ")

except PermissionError :
    print("File Permission Denied ")

#FILEEXISTERROR
#FILEDIRECTORYERROR

except:
    print("Something Went Wrong...")

else:
    pass

finally:
    print("The Program Successfully Runned...")

#our applicaation have any error raise using solved.except for python generate error.



