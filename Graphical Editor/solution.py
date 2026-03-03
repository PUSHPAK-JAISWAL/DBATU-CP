import sys
from collections import deque

M, N = 0, 0
grid = []

def create(m, n):
    global M, N, grid
    M, N = m, n
    grid = [['O'] * M for _ in range(N)]

def clear_table():
    global grid
    for i in range(N):
        for j in range(M):
            grid[i][j] = 'O'

def color_pixel(x, y, c):
    if 1 <= x <= M and 1 <= y <= N:
        grid[y-1][x-1] = c

def vertical(x, y1, y2, c):
    if not (1 <= x <= M):
        return
    if y1 > y2:
        y1, y2 = y2, y1
    for y in range(y1, y2 + 1):
        if 1 <= y <= N:
            grid[y-1][x-1] = c

def horizontal(x1, x2, y, c):
    if not (1 <= y <= N):
        return
    if x1 > x2:
        x1, x2 = x2, x1
    for x in range(x1, x2 + 1):
        if 1 <= x <= M:
            grid[y-1][x-1] = c

def rectangle(x1, y1, x2, y2, c):
    if x1 > x2:
        x1, x2 = x2, x1
    if y1 > y2:
        y1, y2 = y2, y1
    for y in range(y1, y2 + 1):
        for x in range(x1, x2 + 1):
            if 1 <= x <= M and 1 <= y <= N:
                grid[y-1][x-1] = c

def flood_fill(x, y, c):
    if not (1 <= x <= M and 1 <= y <= N):
        return

    old_color = grid[y-1][x-1]
    if old_color == c:
        return

    q = deque()
    q.append((y-1, x-1))
    grid[y-1][x-1] = c

    directions = [(-1,0),(1,0),(0,-1),(0,1)]

    while q:
        cy, cx = q.popleft()
        for dy, dx in directions:
            ny, nx = cy + dy, cx + dx
            if 0 <= ny < N and 0 <= nx < M and grid[ny][nx] == old_color:
                grid[ny][nx] = c
                q.append((ny, nx))

def show(name):
    print(name)
    for row in grid:
        print(''.join(row))

def main():
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue

        parts = line.split()
        command = parts[0]

        if command == 'X':
            break
        elif command == 'I':
            create(int(parts[1]), int(parts[2]))
        elif command == 'C':
            clear_table()
        elif command == 'L':
            color_pixel(int(parts[1]), int(parts[2]), parts[3])
        elif command == 'V':
            vertical(int(parts[1]), int(parts[2]), int(parts[3]), parts[4])
        elif command == 'H':
            horizontal(int(parts[1]), int(parts[2]), int(parts[3]), parts[4])
        elif command == 'K':
            rectangle(int(parts[1]), int(parts[2]),
                      int(parts[3]), int(parts[4]), parts[5])
        elif command == 'F':
            flood_fill(int(parts[1]), int(parts[2]), parts[3])
        elif command == 'S':
            show(parts[1])
        else:
            continue

if __name__ == "__main__":
    main()