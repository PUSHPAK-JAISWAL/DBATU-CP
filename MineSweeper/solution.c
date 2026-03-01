#include<stdio.h>

int main() {
    int n,m;
    int field = 1;

    while(1) {
        scanf("%d %d",&n,&m);

        if (n==0 && m==0)
            break;

        char grid[n][m];
        char result[n][m];

        for(int i = 0;i<n;i++) {
            scanf("%s",grid[i]);
        }


        for(int i = 0;i<n;i++) {
            for(int j = 0;j<m;j++) {
                if(grid[i][j] == '*') {
                    result[i][j] = '*';
                } else {
                    int count = 0;

                    for(int dx = -1;dx<=1;dx++) {
                        for(int dy = -1;dy<=1;dy++) {
                            if(dx==0 && dy == 0) {
                                continue;
                            }

                            int ni = i+dx;
                            int nj = j+dy;

                            if(ni>=0 && ni < n && nj >= 0 && nj<m) {
                                if (grid[ni][nj]=="*")
                                count++;
                            }
                        }
                    }
                    result[i][j] = count+'0';
                }
            }
        }
        if (field>1)
            printf("\n");

        printf("Field #%d:\n",field);

        for(int i = 0;i<n;i++) {
            for(int j = 0;j<m;j++) {
                printf("%c",result[i][j]);
            }
            printf("\n");
        }
        field++;
        
    }
    return 0;
}