import java.io.*;
import java.util.*;

public class solution {

    static int M = 0, N = 0;
    static char[][] grid;

    static void create(int m, int n) {
        M = m;
        N = n;
        grid = new char[N][M];
        for (int i = 0; i < N; i++)
            Arrays.fill(grid[i], 'O');
    }

    static void clearTable() {
        for (int i = 0; i < N; i++)
            Arrays.fill(grid[i], 'O');
    }

    static void colorPixel(int x, int y, char c) {
        if (x >= 1 && x <= M && y >= 1 && y <= N)
            grid[y-1][x-1] = c;
    }

    static void vertical(int x, int y1, int y2, char c) {
        if (x < 1 || x > M) return;
        if (y1 > y2) { int t = y1; y1 = y2; y2 = t; }

        for (int y = y1; y <= y2; y++)
            if (y >= 1 && y <= N)
                grid[y-1][x-1] = c;
    }

    static void horizontal(int x1, int x2, int y, char c) {
        if (y < 1 || y > N) return;
        if (x1 > x2) { int t = x1; x1 = x2; x2 = t; }

        for (int x = x1; x <= x2; x++)
            if (x >= 1 && x <= M)
                grid[y-1][x-1] = c;
    }

    static void rectangle(int x1, int y1, int x2, int y2, char c) {
        if (x1 > x2) { int t = x1; x1 = x2; x2 = t; }
        if (y1 > y2) { int t = y1; y1 = y2; y2 = t; }

        for (int y = y1; y <= y2; y++)
            for (int x = x1; x <= x2; x++)
                if (x >= 1 && x <= M && y >= 1 && y <= N)
                    grid[y-1][x-1] = c;
    }

    static void floodFill(int x, int y, char c) {
        if (x < 1 || x > M || y < 1 || y > N) return;

        char oldColor = grid[y-1][x-1];
        if (oldColor == c) return;

        Queue<int[]> q = new LinkedList<>();
        q.add(new int[]{y-1, x-1});
        grid[y-1][x-1] = c;

        int[] dy = {-1, 1, 0, 0};
        int[] dx = {0, 0, -1, 1};

        while (!q.isEmpty()) {
            int[] cur = q.poll();
            int cy = cur[0];
            int cx = cur[1];

            for (int i = 0; i < 4; i++) {
                int ny = cy + dy[i];
                int nx = cx + dx[i];

                if (ny >= 0 && ny < N && nx >= 0 && nx < M &&
                    grid[ny][nx] == oldColor) {
                    grid[ny][nx] = c;
                    q.add(new int[]{ny, nx});
                }
            }
        }
    }

    static void show(String name) {
        System.out.println(name);
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < M; j++)
                System.out.print(grid[i][j]);
            System.out.println();
        }
    }

    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String line;

        while ((line = br.readLine()) != null) {
            if (line.isEmpty()) continue;

            String[] parts = line.split(" ");
            char command = parts[0].charAt(0);

            if (command == 'X') break;

            switch (command) {
                case 'I':
                    create(Integer.parseInt(parts[1]),
                           Integer.parseInt(parts[2]));
                    break;

                case 'C':
                    clearTable();
                    break;

                case 'L':
                    colorPixel(Integer.parseInt(parts[1]),
                               Integer.parseInt(parts[2]),
                               parts[3].charAt(0));
                    break;

                case 'V':
                    vertical(Integer.parseInt(parts[1]),
                             Integer.parseInt(parts[2]),
                             Integer.parseInt(parts[3]),
                             parts[4].charAt(0));
                    break;

                case 'H':
                    horizontal(Integer.parseInt(parts[1]),
                               Integer.parseInt(parts[2]),
                               Integer.parseInt(parts[3]),
                               parts[4].charAt(0));
                    break;

                case 'K':
                    rectangle(Integer.parseInt(parts[1]),
                              Integer.parseInt(parts[2]),
                              Integer.parseInt(parts[3]),
                              Integer.parseInt(parts[4]),
                              parts[5].charAt(0));
                    break;

                case 'F':
                    floodFill(Integer.parseInt(parts[1]),
                              Integer.parseInt(parts[2]),
                              parts[3].charAt(0));
                    break;

                case 'S':
                    show(parts[1]);
                    break;

                default:
                    
                    break;
            }
        }
    }
}