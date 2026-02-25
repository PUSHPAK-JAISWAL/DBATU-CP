memo <- new.env()
memo[["1"]] <-1

cycle_length <- function(n) {
    key <- as.character(n)

    if(exists(key,envir = memo)) {
        return(memo[[key]])
    }


    if(n%%2 == 0) {
        length <- 1+cycle_length(n/2)
    } else {
        length <- 1+cycle_length(3*n+1)
    }

    memo[[key]] <- length
    return(length)
}

con <- file("stdin","r")

while(TRUE) {
    line<-readLines(con,n=1)
    if(length(line)==0) break

    parts<-as.numeric(strsplit(line,"\\s+")[[1]])
    i<-parts[1]
    j<-parts[2]

    start <- min(i,j)
    end <- max(i,j)

    max_cycle <- 0

    for(k in start:end) {
        max_cycle <- max(max_cycle,cycle_length(k))
    }
    cat(i,j,max_cycle,"\n")
}
close(con)