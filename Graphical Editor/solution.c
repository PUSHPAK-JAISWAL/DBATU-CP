#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 250

int M = 0, N = 0;
char grid[MAX][MAX];

void create(int m, int n) {
    M = m;
    N = n;
    for (int i = 0; i < N; i++)
        for (int j = 0; j < M; j++)
            grid[i][j] = 'O';
}

void clear_table() {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < M; j++)
            grid[i][j] = 'O';
}

void color_pixel(int x, int y, char c) {
    if (x >= 1 && x <= M && y >= 1 && y <= N)
        grid[y-1][x-1] = c;
}

void vertical(int x, int y1, int y2, char c) {
    if (x < 1 || x > M) return;
    if (y1 > y2) { int t = y1; y1 = y2; y2 = t; }

    for (int y = y1; y <= y2; y++)
        if (y >= 1 && y <= N)
            grid[y-1][x-1] = c;
}

void horizontal(int x1, int x2, int y, char c) {
    if (y < 1 || y > N) return;
    if (x1 > x2) { int t = x1; x1 = x2; x2 = t; }

    for (int x = x1; x <= x2; x++)
        if (x >= 1 && x <= M)
            grid[y-1][x-1] = c;
}

void rectangle(int x1, int y1, int x2, int y2, char c) {
    if (x1 > x2) { int t = x1; x1 = x2; x2 = t; }
    if (y1 > y2) { int t = y1; y1 = y2; y2 = t; }

    for (int y = y1; y <= y2; y++)
        for (int x = x1; x <= x2; x++)
            if (x >= 1 && x <= M && y >= 1 && y <= N)
                grid[y-1][x-1] = c;
}

void flood_fill(int x, int y, char c) {
    if (x < 1 || x > M || y < 1 || y > N) return;

    char old = grid[y-1][x-1];
    if (old == c) return;

    int qy[MAX*MAX], qx[MAX*MAX];
    int front = 0, back = 0;

    qy[back] = y-1;
    qx[back] = x-1;
    back++;

    grid[y-1][x-1] = c;

    int dy[4] = {-1, 1, 0, 0};
    int dx[4] = {0, 0, -1, 1};

    while (front < back) {
        int cy = qy[front];
        int cx = qx[front];
        front++;

        for (int i = 0; i < 4; i++) {
            int ny = cy + dy[i];
            int nx = cx + dx[i];

            if (ny >= 0 && ny < N && nx >= 0 && nx < M &&
                grid[ny][nx] == old) {
                grid[ny][nx] = c;
                qy[back] = ny;
                qx[back] = nx;
                back++;
            }
        }
    }
}

void show(char *name) {
    printf("%s\n", name);
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++)
            printf("%c", grid[i][j]);
        printf("\n");
    }
}

int main() {
    char command;

    while (scanf(" %c", &command) == 1) {

        if (command == 'X') break;

        if (command == 'I') {
            int m, n;
            scanf("%d %d", &m, &n);
            create(m, n);
        }
        else if (command == 'C') {
            clear_table();
        }
        else if (command == 'L') {
            int x, y;
            char c;
            scanf("%d %d %c", &x, &y, &c);
            color_pixel(x, y, c);
        }
        else if (command == 'V') {
            int x, y1, y2;
            char c;
            scanf("%d %d %d %c", &x, &y1, &y2, &c);
            vertical(x, y1, y2, c);
        }
        else if (command == 'H') {
            int x1, x2, y;
            char c;
            scanf("%d %d %d %c", &x1, &x2, &y, &c);
            horizontal(x1, x2, y, c);
        }
        else if (command == 'K') {
            int x1, y1, x2, y2;
            char c;
            scanf("%d %d %d %d %c", &x1, &y1, &x2, &y2, &c);
            rectangle(x1, y1, x2, y2, c);
        }
        else if (command == 'F') {
            int x, y;
            char c;
            scanf("%d %d %c", &x, &y, &c);
            flood_fill(x, y, c);
        }
        else if (command == 'S') {
            char name[20];
            scanf("%s", name);
            show(name);
        }
        else {
            char buffer[256];
            fgets(buffer, sizeof(buffer), stdin);  
        }
    }

    return 0;
}