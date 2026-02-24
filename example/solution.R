# Standard way to get terminal input in Rscript
cat("Enter your name: ")
name <- readLines("stdin", n = 1)

cat(paste("Hello,", name, "\n"))