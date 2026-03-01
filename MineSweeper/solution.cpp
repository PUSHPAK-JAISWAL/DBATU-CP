#include<bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(NULL);

    int n,m;
    int field = 1;

    while(true) {
        cin>>n>>m;

        if(!cin || (n== 0 && m==0))
            break;

        vector<string> grid(n);
        for(int i = 0;i<n;i++) {
            cin>>grid[i];
        }

        vector<string> result(n,string(m,'0'));

        for(int i = 0;i<n;i++) {
            for(int j = 0;j<m;j++) {
                if(grid[i][j]=='*') {
                    result[i][j]='*';
                }else {
                    int count = 0;

                    for(int dx = -1;dx<=1;dx++) {
                        for(int dy =-1;dy<=1;dy++) {
                            if(dx==0 && dy == 0) 
                                continue;

                            int ni = i+dx;
                            int nj = j+dy;
                            if(ni>=0 && ni<n && nj>=0 && nj<m) {
                                if(grid[ni][nj]=='*')
                                    count++;
                            }
                        }
                    }
                    result[i][j] = char(count+'0');
                }
            }
        }
        if(field>1) 
            cout<<"\n";

        cout<< "Field #"<<field<< ":\n";
        for(int i = 0;i<n;i++) {
            cout << result[i]<< "\n";
        }
        field++;
    }
    return 0;
}