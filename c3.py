class Student():
    sum1 = 0
    name = ''
    age = 0

    def __init__(self,name):
        self.name = name
        self.__score = 0
        self.__class__.sum1 += 1						
        # print('当前学生总数:' +str(self.__class__.sum1) )

    def marking(self,score):
        if score < 0:
            # print('分数不能为负数')
            # return
            return '分数不能为负数'
        self.__score = score
        print(self.name + '同学的分数是：' + str(self.__score))


student1 = Student('lili')
student2 = Student('lele')	
student1.marking(20)	  						
student1.__score = -1
print(student1.__score)
# print(student2.__score)
# print(student1.__dict__)
print(student2.__dict__)