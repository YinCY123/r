x <- as.double(readline(prompt = "what is the value of x? "))
cat("I got the number ", format(x, digits = 6), ".\n")
if(x < 0){
    print("why would you give me a negative number?")
    x <- abs(x)
}

y <- sqrt(x)
