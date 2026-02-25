#include <iostream>
#include <unordered_map>

using namespace std;

unordered_map<long long,long long> memo;

long long cycleLength(long long n ) {
    if(n==1)
        return 1;

    if(memo.count(n))
        return memo[n];

    long long length;
    if(n%2 == 0) 
        length = 1+cycleLength(n/2);
    else 
        length = 1+cycleLength(n+1);

    memo[n] = length;
    return length;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(NULL);

    long long i,j;

    while(cin>>i>>j) {
        long long start = min(i,j);
        long long end = max(i,j);

        long long maxCycle = 0;

        for(long long k = start;k<= end;k++) {
            maxCycle = max(maxCycle,cycleLength(k));
        }
        cout<< i<< " " << j << " "<<maxCycle<<"\n";
    }
    return 0;
}