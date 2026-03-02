repeat {
    n<- as.integer(readLines("stdin",n=1))

    if(n==0) {
        break
    }

    expenses<-numeric(n)
    total<-0


    for(i in 1:n) {
        amount <- as.numeric(readLines("stdin",n=1))
        cents <- round(amount*100)
        expenses[i]<-cents
        total<-total + cents
    }

    avg<- floor(total/n)

    give<-0
    take<-0

    for(e in expenses) {
        if(e>avg) {
            give<-give + (e-avg)
        } else {
            take <- take +(avg-e)
        }
    }
    result<-max(give,take)

    cat(sprintf("$%.2f\n",result/100))
}
