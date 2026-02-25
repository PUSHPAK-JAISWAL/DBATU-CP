#include <stdio.h>

#define MAX 1000000

long memo[MAX] = {0};

long cycleLength(long n ) {
    if(n==1)
        return 1;

    if(n<MAX && memo[n] != 0)
        return memo[n];

    long length;
    if(n%2==0)
        length = 1+cycleLength(n/2);

    else
        length = 1+cycleLength(3*n+1);

    if(n<MAX) 
        memo[n] = length;

    return length;
}

int main() {
    long i,j;

    while(scanf("%ld %ld",&i,&j)==2) {
        long start = i<j ? i:j;
        long end = i>j ? i:j;

        long maxCycle = 0;

        for(long k=start;k<=end;k++) {
            long length = cycleLength(k);
            if(length>maxCycle)
                maxCycle = length;
        }

        printf("%ld %ld %ld",i,j,maxCycle);
    }
    return 0;
}