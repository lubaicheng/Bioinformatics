from c4 import Human

class Student(Human):
   
    def __init__(self,school,name,age):
        self.school = school
        # Human.__init__(self,name,age) 
        super(Student,self).__init__(name,age)

    def do_homework(self):
        super(Student,self).do_homework()
        print('english homework')

student1 = Student('xuexiao','石敢当',18)
# print(student1.sum)
# print(Student.sum)    
print(student1.name,student1.age)   
student1.do_homework()  
# student1.get_name()
# print(student1.name)      







