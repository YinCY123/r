#-------------------------------
# R 语言实现封装

#定义老师对象和行为
teacher <- function(x, ...)UseMethod("teacher")
teacher.lecture <- function(x)print("讲课")
teacher.assignment <- function(x)print("布置作业")
teacher.correcting <- function(x)print("批改作业")
teacher.default <- function(x)print("你不是teacher")


#定义学生对象和行为
student <- function(x, ...)UseMethod("student")
student.attend <- function(x)print("听课")
student.homework <- function(x)print("写作业")
student.default <- function(x)print("你不是student")
student.exam <- function(x)print("考试")

#定义两个变量
a <- "teacher"
b <- "student"

#给老师变量设置行为
attr(a, "class") <- "lecture"
#执行老师行为
teacher(a)

#给学生变量设置行为
attr(b, "class") <- "attend"

#执行学生的行为
student(b)


attr(a, "class") <- "assignment"
teacher(a)

attr(b, "class") <- "correcting"
teacher(b)

attr(a, "class") <- "correcting"
teacher(a)

attr(b, "class") <- "exam"
student(b)


#定义一个变量，即使老师又是同学
ab <- "student_teacher"
attr(ab, "class") <- c("lecture", "homework")
teacher(ab)
student(ab)


#-------------------------------------------------
# R语言实现继承

#给同学增加新的行为
student.correcting <- function(x)print("帮助老师批改作业")

#辅助变量用于设置初始值
char0 <- character(0)

#实现继承关系
create <- function(classes = char0, parents = char0){
    mro = c(classes)
    for (name in parents){
        mro = c(mro, name)
        ancestor <- attr(get(name), "type")
        mro <- c(mro, ancestor[ancestor != name])
    }
    return(mro)
}

# 定义构造函数，创建对象
NewInstance <- function(value = 0, classes = char0, parents = char0){
    obj = value
    attr(obj, "type") <- create(classes, parents)
    attr(obj, "class") <- c("homework", "attend", "exam")
    return(obj)
}


# 创建父对象实例
studentObj <- NewInstance()


# 创建子对象实例
s1 <- NewInstance(value = "普通同学", classes = "normal", parents = "studentObj")
s2 <- NewInstance(value = "课代表", classes = "leader", parents = "studentObj")


# 给课代表增加批改作业的行为
attr(x = s2, which = "class") <- c(attr(s2, "class"), "correcting")

# 查看普通同学的对象实例
s1

#查看课代表的对象实例
s2

#---------------------------------
# R语言实现多态性
# 创建优等生和次等生两个实例
e1 <- NewInstance(value = "优等生", classes = "excellent", parents = "studentObj")
e2 <- NewInstance(value = "次等生", classes = "poor", parents = "studentObj")


# 修改同学考试行为，大于85分为优秀，小于70分为及格
student.exam <- function(x, score){
    p <- "考试"
    if(score > 85) print(p, "优秀", sep = "")
    if(score < 70)print(p, "及格", sep = "")
}

# 执行优等生考试行为
attr(e1, "class") <- "exam"
student(e1,90)

attr(e2, "class") <- "exam"
student(e2, 66)


#------------------------------
#R的面向过程编程

#定义老师和学生两个对象和行为
#辅助变量用于设置初始值
char0 <- character(1)

#定义老师对象和行为
teacher_fun <- function(x = char0){
    if(x == 'lecture'){
        print("讲课")
    }else if(x == "assignment"){
        print("布置作业")
    }else if(x == "correcting"){
        print("批改作业")
    }else{
        print("你不是student")
    }
}

#定义学生对象和行为
student_fun <- function(x = char0){
    if(x == "attend"){
        print("听课")
    }else if(x == "homework"){
        print("写作业")
    }else if(x == "exam"){
        print("考试")
    }else{
        print("你不是student")
    }
}

#执行老师的一个行为
teacher_fun("lecture")

#执行学生的一个行为
student_fun("attend")












