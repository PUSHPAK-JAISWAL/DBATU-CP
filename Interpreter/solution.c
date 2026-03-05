#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void solve() {
    char line[100];
    if (!fgets(line, sizeof(line), stdin)) return;

    int num_cases = atoi(line);
    fgets(line, sizeof(line), stdin);

    for (int t = 0; t < num_cases; t++) {
        int ram[1000] = {0};
        int reg[10] = {0};
        int addr = 0;

        while (fgets(line, sizeof(line), stdin) && line[0] != '\n' && line[0] != '\r') {
            ram[addr++] = atoi(line);
        }

        int pc = 0;
        int count = 0;

        while (1) {
            count++;
            int instr = ram[pc];
            int cmd = instr / 100;
            int d = (instr / 10) % 10;
            int n = instr % 10;

            pc++;

            if (cmd == 1) {
                break;
            } else if (cmd == 2) {
                reg[d] = n;
            } else if (cmd == 3) {
                reg[d] = (reg[d] + n) % 1000;
            } else if (cmd == 4) {
                reg[d] = (reg[d] * n) % 1000;
            } else if (cmd == 5) {
                reg[d] = reg[n];
            } else if (cmd == 6) {
                reg[d] = (reg[d] + reg[n]) % 1000;
            } else if (cmd == 7) {
                reg[d] = (reg[d] * reg[n]) % 1000;
            } else if (cmd == 8) {
                reg[d] = ram[reg[n]];
            } else if (cmd == 9) {
                ram[reg[n]] = reg[d];
            } else if (cmd == 0) {
                if (reg[n] != 0) {
                    pc = reg[d];
                }
            }
        }

        printf("%d\n", count);
        if (t < num_cases - 1) {
            printf("\n");
        }
    }
}

int main() {
    solve();
    return 0;
}