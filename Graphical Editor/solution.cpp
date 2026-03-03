#include <bits/stdc++.h>
using namespace std;

int M = 0, N = 0;
vector<vector<char>> grid;

void create(int m, int n) {
    M = m;
    N = n;
    grid.assign(N, vector<char>(M, 'O'));
}

void clear_table() {
    for (int i = 0; i < N; i++)
        fill(grid[i].begin(), grid[i].end(), 'O');
}

void color_pixel(int x, int y, char c) {
    if (x >= 1 && x <= M && y >= 1 && y <= N)
        grid[y-1][x-1] = c;
}

void vertical(int x, int y1, int y2, char c) {
    if (x < 1 || x > M) return;
    if (y1 > y2) swap(y1, y2);

    for (int y = y1; y <= y2; y++)
        if (y >= 1 && y <= N)
            grid[y-1][x-1] = c;
}

void horizontal(int x1, int x2, int y, char c) {
    if (y < 1 || y > N) return;
    if (x1 > x2) swap(x1, x2);

    for (int x = x1; x <= x2; x++)
        if (x >= 1 && x <= M)
            grid[y-1][x-1] = c;
}

void rectangle_fill(int x1, int y1, int x2, int y2, char c) {
    if (x1 > x2) swap(x1, x2);
    if (y1 > y2) swap(y1, y2);

    for (int y = y1; y <= y2; y++)
        for (int x = x1; x <= x2; x++)
            if (x >= 1 && x <= M && y >= 1 && y <= N)
                grid[y-1][x-1] = c;
}

void flood_fill(int x, int y, char c) {
    if (x < 1 || x > M || y < 1 || y > N) return;

    char old_color = grid[y-1][x-1];
    if (old_color == c) return;

    queue<pair<int,int>> q;
    q.push({y-1, x-1});
    grid[y-1][x-1] = c;

    int dy[4] = {-1, 1, 0, 0};
    int dx[4] = {0, 0, -1, 1};

    while (!q.empty()) {
        auto [cy, cx] = q.front();
        q.pop();

        for (int i = 0; i < 4; i++) {
            int ny = cy + dy[i];
            int nx = cx + dx[i];

            if (ny >= 0 && ny < N && nx >= 0 && nx < M &&
                grid[ny][nx] == old_color) {
                grid[ny][nx] = c;
                q.push({ny, nx});
            }
        }
    }
}

void show(const string &name) {
    cout << name << "\n";
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++)
            cout << grid[i][j];
        cout << "\n";
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    char command;

    while (cin >> command) {

        if (command == 'X') break;

        if (command == 'I') {
            int m, n;
            cin >> m >> n;
            create(m, n);
        }
        else if (command == 'C') {
            clear_table();
        }
        else if (command == 'L') {
            int x, y;
            char c;
            cin >> x >> y >> c;
            color_pixel(x, y, c);
        }
        else if (command == 'V') {
            int x, y1, y2;
            char c;
            cin >> x >> y1 >> y2 >> c;
            vertical(x, y1, y2, c);
        }
        else if (command == 'H') {
            int x1, x2, y;
            char c;
            cin >> x1 >> x2 >> y >> c;
            horizontal(x1, x2, y, c);
        }
        else if (command == 'K') {
            int x1, y1, x2, y2;
            char c;
            cin >> x1 >> y1 >> x2 >> y2 >> c;
            rectangle_fill(x1, y1, x2, y2, c);
        }
        else if (command == 'F') {
            int x, y;
            char c;
            cin >> x >> y >> c;
            flood_fill(x, y, c);
        }
        else if (command == 'S') {
            string name;
            cin >> name;
            show(name);
        }
        else {
            string dummy;
            getline(cin, dummy);
        }
    }

    return 0;
}