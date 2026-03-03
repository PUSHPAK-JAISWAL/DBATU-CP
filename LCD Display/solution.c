#include <stdio.h>
#include <string.h>

int main() {
    
    int seg[10][7] = {
        {1,1,1,1,1,1,0}, 
        {0,1,1,0,0,0,0}, 
        {1,1,0,1,1,0,1}, 
        {1,1,1,1,0,0,1}, 
        {0,1,1,0,0,1,1}, 
        {1,0,1,1,0,1,1}, 
        {1,0,1,1,1,1,1}, 
        {1,1,1,0,0,0,0}, 
        {1,1,1,1,1,1,1}, 
        {1,1,1,1,0,1,1}  
    };

    int s;
    long n;

    while (1) {
        scanf("%d %ld", &s, &n);
        if (s == 0 && n == 0) break;

        char str[20];
        sprintf(str, "%ld", n);
        int len = strlen(str);

        int rows = 2 * s + 3;

        for (int r = 0; r < rows; r++) {
            for (int d = 0; d < len; d++) {
                int digit = str[d] - '0';

                
                if (r == 0) {
                    printf(" ");
                    if (seg[digit][0])
                        for (int i = 0; i < s; i++) printf("-");
                    else
                        for (int i = 0; i < s; i++) printf(" ");
                    printf(" ");
                }
                
                else if (r >= 1 && r <= s) {
                    if (seg[digit][5]) printf("|");
                    else printf(" ");
                    for (int i = 0; i < s; i++) printf(" ");
                    if (seg[digit][1]) printf("|");
                    else printf(" ");
                }
                
                else if (r == s + 1) {
                    printf(" ");
                    if (seg[digit][6])
                        for (int i = 0; i < s; i++) printf("-");
                    else
                        for (int i = 0; i < s; i++) printf(" ");
                    printf(" ");
                }
                
                else if (r >= s + 2 && r <= 2 * s + 1) {
                    if (seg[digit][4]) printf("|");
                    else printf(" ");
                    for (int i = 0; i < s; i++) printf(" ");
                    if (seg[digit][2]) printf("|");
                    else printf(" ");
                }
                
                else if (r == 2 * s + 2) {
                    printf(" ");
                    if (seg[digit][3])
                        for (int i = 0; i < s; i++) printf("-");
                    else
                        for (int i = 0; i < s; i++) printf(" ");
                    printf(" ");
                }

                if (d != len - 1) printf(" ");
            }
            printf("\n");
        }
        printf("\n");
    }

    return 0;
}