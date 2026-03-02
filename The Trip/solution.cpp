#include <iostream>
#include <vector>
#include <iomanip>
#include <cmath>

using namespace std;

int main() {
    while(true) {
        int n;
        cin>>n;

        if(n==0)
            break;

        vector<long long> expenses(n);
        long long total = 0;

        for(int i = 0;i<n;i++) {
            double amount;
            cin>>amount;
            expenses[i] = llround(amount*100);
            total += expenses[i];


        }

        long long avg = total /n;

        long long give = 0, take = 0;

        for(int i = 0;i<n;i++) {
            if(expenses[i]>avg) 
                give+=expenses[i]-avg;
            else
                take += avg-expenses[i];
        }

        long long result = max(give,take);

        cout<<"$"<<fixed<<setprecision(2)<<result/100.0<<endl;
    }
    return 0;
}