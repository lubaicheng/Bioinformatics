class Student():

    def __init__(self,name,age):
        self.name = name
        self.age = age
    
    # def get_name(self):
    #     print(self.name)
    def do_homework(self):
        print('math homework')

student1 = Student('l',18)
student1.do_homework()