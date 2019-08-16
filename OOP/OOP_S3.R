#-----------------------
# 创建S3对象
library(pryr)

## 通过变量创建S3对象
x <- 1
attr(x, "class") <- "foo"
x

class(x)

otype(x)

## 通过structure() 函数创建 S3 对象
y <- structure(.Data = 2, class = "foo")

class(y)

otype(y)


# 创建一个多类型的 S3对象
## S3 对象没有明确的结构关系，一个S3对象可以由多个类型，
## S3对象的class 属性可以是一个向量，包括多种类型。
x <- 1
attr(x, 'class') <- c("foo", "bar")

class(x)

otype(x)

#------------------------
#泛型函数和方法调用
## 对于S3 对象的使用，通常用 UseMethod() 函数来定义一个泛型函数的名称，
## 通过传入参数的class属性来确定不同的方法调用。

## 定义一个teacher的泛型函数

# -用UseMethod()定义teacher泛型函数
# -用teacher.xxx的语法格式定义teacher对象的行为
# -其中teacher.default是默认行为

# 用UseMethod() 定义teacher泛型函数
teacher <- function(x, ...) UseMethod("teacher")

# 用pryr包中ftype()函数，检查teacher的类型
ftype(teacher)

# 定义teacher内部函数
teacher.lecture <- function(x)print("讲课")
teacher.assignment <- function(x)print("布置作业")
teacher.correcting <- function(x)print("批改作业")
teacher.default <- function(x)print("你不是teacher")

## 方法调用时，通过传入参数的 class 属性来确定不同的方法调用。
#   -定义一个变量a, 并z设置a 的class 属性为 lecture
#   -把变量a传入到 teacher 泛型函数中
#   -函数teacher.lecture()函数的行为被调用

a <- teacher
attr(a, 'class') <- "lecture"
teacher(a)

teacher()

## 当然也可以直接调用 teacher 中定义的行为，如果这样做就失去了封装的意义。
teacher.lecture()

teacher.lecture(a)

teacher()


#---------------------------
# 查看S3 对象的函数
# 当我们使用S3对象进行面向对象封装后，可以使用 methods() 函数来查看S3对象
# 中定义的内部函数。

# 查看teacher对象
teacher

# 查看teacher对象的内部函数
methods(teacher)

# 通过methods()的generic.function参数来匹配泛型函数名字
methods(generic.function = predict)


# 通过methods()的class参数来匹配类的名字
methods(class = lm)

# 用getAnywhere()函数查看所有函数
getAnywhere(x = teacher.lecture)


# 查看不可见函数 predict.ppr
predict.ppr

exists("predict.ppr")

# getAnywhere函数查找predict.ppr
getAnywhere(x = "predict.ppr")


# 使用getS3method()函数也可以查看不可见的函数
# getS3method()函数查找predict.ppr
getS3method(f = "predict", class = "ppr")


#------------------------
# S3对象的继承关系
## S3对象有一种非常简单的继承方式，用NextMethod()函数来实现
## 定义一个node泛型函数
node <- function(x)UseMethod(generic = "node", object = x)

node.father <- function(x)"Default node"

# father function
node.father <- function(x)c("father")

# son函数，通过NextMethod()函数指向father函数
node.son <- function(x)c("son", NextMethod())


# 定义n1
n1 <- structure(.Data = 1, class = c("father"))
node(n1)


# 定义n2, 设置class属性为两个
n2 <- structure(.Data = 1, class = c("son", "father"))

#在node函数中传入 n2，执行node.son()函数和node.father()函数
node(n2)


# 通过对 node()函数传入n2的参数,node.son()先被执行，然后通过NextMethod()函数继续执行了
# node.father()函数。这样其实就模拟了，子函数叫用父函数的过程，实现了面向对象编程中的继承。


#-----------------------------
# S3对象的缺点
# 从上面对S3对象的介绍来看，S3对象并不是完全的面向对象实现，而是一种通过泛型函数模
# 拟的面向对象的实现。
#   - S3 使用起来简单，但在实际的面向对象编程过程中，当对象关系有一定的复杂度，S3对
#     象所表达的意义就会变得不太清楚。
#   - S3封装的内部函数可以绕过泛型函数的检查直接被调用
#   - S3参数的class属性，可以被任意设置，没有与处理的检查
#   - S3参数只能通过调用class属性进行函数调用，其他属性则不会被class()函数执行
#   - S3参数的class属性有多个值时，调用会按照程序赋值顺序来调用第一个合法的函数
#所以，S3只时R语言面向对象的一种简单实现。  


#--------------------
# S3对象的使用
# base包的S3对象

# mean函数
mean
ftype(mean)


# t 函数
ftype(t)

# plot 函数
ftype(plot)


# 自定义的S3对象
a <- 1
class(a)

#定义泛型函数f1
f1 <- function(x){
  a <- 2
  UseMethod(generic = "f1")
}

#定义f1的内部函数
f1.numeric <- function(x)a

# 给f1 传入变量a 
f1(a)

f1(99)


# 定义f1 内部函数
f1.character <- function(x)paste("char", x)
f1("a")

