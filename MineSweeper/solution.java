import java.io.BufferedReader;
import java.io.InputStreamReader;

public class solution {
    public static void main(String args[]) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder output = new StringBuilder();

        int field = 1;

        while(true) {
            String line = br.readLine();
            if(line == null) break;
            
            String[] parts = line.split(" ");
            int n = Integer.parseInt(parts[0]);
            int m = Integer.parseInt(parts[1]);

            if(n== 0 && m == 0) {
                break;
            }

            char[][] grid = new char[n][m];

            for(int i = 0;i<n;i++) {
                grid[i] = br.readLine().toCharArray();
            }

            char[][] result = new char[n][m];

            for(int i = 0;i<n;i++) {
                for(int j = 0;j<m;j++) {
                    if(grid[i][j] == '*') {
                        result[i][j] = '*';
                    } else {
                        int count = 0;

                        for(int dx = -1;dx<=1;dx++) {
                            for(int dy = -1;dy<=1;dy++) {
                                if(dx == 0 && dy==0)
                                    continue;

                                int ni = i+dx;
                                int nj = j+dy;

                                if(ni>=0 && ni<n && nj>=0 && nj<m) {
                                    if(grid[ni][nj]=='*')
                                        count++;
                                }
                            }
                        }
                        result[i][j]=(char) (count+'0');
                    }
                }
            }
            if(field>1) 
                output.append("\n");

            output.append("Field #").append(field).append(":\n");

            for(int i = 0;i<n;i++) {
                output.append(new String(result[i])).append("\n");
            }
            field++;
        }
        System.out.println(output);
    }
}