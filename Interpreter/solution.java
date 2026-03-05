import java.util.*;
import java.io.*;

public class solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        if(!sc.hasNextInt()) return;

        int numCases = Integer.parseInt(sc.nextLine());
        if(sc.hasNextLine()) sc.nextLine();


        for(int t = 0;t<numCases;t++) {
            int[] ram = new int[1000];
            int[] reg = new int[10];
            int addr = 0;

            while(sc.hasNextLine()) {
                String line = sc.nextLine().trim();
                if(line.isEmpty()) break;
                ram[addr++] = Integer.parseInt(line);
            }

            int pc = 0;
            int count = 0;

            while(true) {
                count++;
                int instr = ram[pc];
                int cmd = instr /100;
                int d = (instr/10)%10;
                int n = instr%10;


                pc++;

                if(cmd == 1) break;

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

            System.out.println(count);

            if(t<numCases-1) {
                System.out.println();
            }
        }
    }
}