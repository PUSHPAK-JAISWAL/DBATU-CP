#include <iostream>
#include <string>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    
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
    long long n;

    while (true) {
        cin >> s >> n;
        if (!cin || (s == 0 && n == 0)) break;

        string str = to_string(n);
        int rows = 2 * s + 3;

        for (int r = 0; r < rows; r++) {
            for (int d = 0; d < str.size(); d++) {
                int digit = str[d] - '0';

                
                if (r == 0) {
                    cout << " ";
                    cout << (seg[digit][0] ? string(s, '-') : string(s, ' '));
                    cout << " ";
                }
                
                else if (r >= 1 && r <= s) {
                    cout << (seg[digit][5] ? "|" : " ");
                    cout << string(s, ' ');
                    cout << (seg[digit][1] ? "|" : " ");
                }
                
                else if (r == s + 1) {
                    cout << " ";
                    cout << (seg[digit][6] ? string(s, '-') : string(s, ' '));
                    cout << " ";
                }
                
                else if (r >= s + 2 && r <= 2 * s + 1) {
                    cout << (seg[digit][4] ? "|" : " ");
                    cout << string(s, ' ');
                    cout << (seg[digit][2] ? "|" : " ");
                }
                
                else if (r == 2 * s + 2) {
                    cout << " ";
                    cout << (seg[digit][3] ? string(s, '-') : string(s, ' '));
                    cout << " ";
                }

                if (d != str.size() - 1) cout << " ";
            }
            cout << "\n";
        }
        cout << "\n";
    }

    return 0;
}