import java.io.*;
import java.util.*;

public class solution {

    static int[][] seg = {
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

    public static void main(String[] args) throws Exception {

        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String line;

        while (true) {
            line = br.readLine();
            if (line == null) break;

            StringTokenizer st = new StringTokenizer(line);
            int s = Integer.parseInt(st.nextToken());
            long n = Long.parseLong(st.nextToken());

            if (s == 0 && n == 0) break;

            String str = String.valueOf(n);
            int rows = 2 * s + 3;

            for (int r = 0; r < rows; r++) {

                StringBuilder sb = new StringBuilder();

                for (int d = 0; d < str.length(); d++) {
                    int digit = str.charAt(d) - '0';

                    
                    if (r == 0) {
                        sb.append(" ");
                        sb.append(seg[digit][0] == 1 ? "-".repeat(s) : " ".repeat(s));
                        sb.append(" ");
                    }
                    
                    else if (r >= 1 && r <= s) {
                        sb.append(seg[digit][5] == 1 ? "|" : " ");
                        sb.append(" ".repeat(s));
                        sb.append(seg[digit][1] == 1 ? "|" : " ");
                    }
                    
                    else if (r == s + 1) {
                        sb.append(" ");
                        sb.append(seg[digit][6] == 1 ? "-".repeat(s) : " ".repeat(s));
                        sb.append(" ");
                    }
                    
                    else if (r >= s + 2 && r <= 2 * s + 1) {
                        sb.append(seg[digit][4] == 1 ? "|" : " ");
                        sb.append(" ".repeat(s));
                        sb.append(seg[digit][2] == 1 ? "|" : " ");
                    }
                    
                    else if (r == 2 * s + 2) {
                        sb.append(" ");
                        sb.append(seg[digit][3] == 1 ? "-".repeat(s) : " ".repeat(s));
                        sb.append(" ");
                    }

                    if (d != str.length() - 1) sb.append(" ");
                }

                System.out.println(sb);
            }

            System.out.println();
        }
    }
}