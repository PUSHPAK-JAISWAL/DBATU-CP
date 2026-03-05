#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

void solve() {
    string line;
    if (!getline(cin, line) || line.empty()) return;

    int num_cases = stoi(line);
    getline(cin, line); // Skip the initial blank line

    for (int t = 0; t < num_cases; t++) {
        vector<int> ram(1000, 0);
        vector<int> reg(10, 0);
        int addr = 0;

        while (getline(cin, line) && !line.empty()) {
            ram[addr++] = stoi(line);
        }

        int pc = 0;
        int count = 0;

        while (true) {
            count++;
            int instr = ram[pc];
            int cmd = instr / 100;
            int d = (instr / 10) % 10;
            int n = instr % 10;

            pc++;

            if (cmd == 1) break;

            switch (cmd) {
                case 2: reg[d] = n; break;
                case 3: reg[d] = (reg[d] + n) % 1000; break;
                case 4: reg[d] = (reg[d] * n) % 1000; break;
                case 5: reg[d] = reg[n]; break;
                case 6: reg[d] = (reg[d] + reg[n]) % 1000; break;
                case 7: reg[d] = (reg[d] * reg[n]) % 1000; break;
                case 8: reg[d] = ram[reg[n]]; break;
                case 9: ram[reg[n]] = reg[d]; break;
                case 0: if (reg[n] != 0) pc = reg[d]; break;
            }
        }

        cout << count << endl;
        if (t < num_cases - 1) {
            cout << endl;
        }
    }
}

int main() {
    solve();
    return 0;
}