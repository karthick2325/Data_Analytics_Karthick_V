from abc import ABC,abstractmethod

class person(ABC):
    def __init__(self,name,email):
        self.name=name
        self.email=email
    @abstractmethod
    def display_role(self):
        return "University Person"
    @abstractmethod
    def display_dashboard
    
class student(person):
    def __init__(self,name,email,dept):
        super().__init__(name,email)
        self.dept=dept

class teacher(student):
    def __init__(self,name,email,subject):
        super().__init__(name,email)
        self.subject=subject
        