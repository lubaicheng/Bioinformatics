class Student():
    # # sum1 = 0
    # name = ''
    # # age = 0
    # score = 0

    def __init__(self,name):
        self.name = name
        # self.age = age
        # self.score = 0
        # self.__class__.sum1 += 1						#类变量的作用与使用方法和场景
        # print('当前学生总数:' +str(self.__class__.sum1) )

    # def do_english(self):
    #     print('english')

    def marking(self,score):
        if score < 0:
            # print('分数不能为负数')
            # return
            return '分数不能为负数'
        self.score = score
        print(self.name + '同学的分数是：' + str(self.score))

    # def do_homework(self):
    #     self.do_english()
    #     print('homework',self.name,self.age)

student1 = Student('lili')
# student1.score = 3
# result1 = student1.marking(-2)
# print(result1)
student1.marking(20)
student1.score = -1
print(student1.score)
# print(result)

# student1.do_homework()
# student2 = Student('lelel',19)
# student2.do_homework()
# student3 = Student('qqq',18)
# student3.do_homework()