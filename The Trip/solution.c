#include<stdio.h>
#include <stdlib.h>
#include <math.h>

int main() {
    int n;

    while(1) {
        scanf("%d",&n);
        if(n==0)
            break;

        long expenses[1000];
        long total = 0;


        for(int i = 0;i<n;i++) {
            double amount;
            scanf("%lf",&amount);
            expenses[i] = (long)round(amount*100);
            total += expenses[i];
        }

        long avg = total/n;

        long give = 0, take = 0;

        for(int i =0;i<n;i++) {
            if(expenses[i]>avg)
                give+=expenses[i]-avg;
            else
                take+=avg-expenses[i];
        }

        long result = (give>take)?give:take;

        printf("$%.2f\n",result/100.0);
    }
    return 0;
}