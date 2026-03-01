import sys

def solve():
    data = sys.stdin.read().split()
    idx = 0
    field = 1
    output = []

    while True:
        n = int(data[idx])
        m = int(data[idx+1])
        idx +=2

        if n == 0 and m == 0:
            break

        grid = [list(data[idx+i]) for i in range(n)]
        idx +=n
        
        result = [['0']*m for _ in range(n)]

        for i in range(n):
            for j in range(m):
                if grid[i][j] == '*':
                    result[i][j] = '*'

                else:
                    count = 0
                    for dx in (-1,0,1):
                        for dy in(-1,0,1):
                            if dx == 0 and dy == 0:
                                continue
                                
                            ni,nj = i+dx,j+dy
                            if 0<= ni<n and 0 <= nj<m and grid[ni][nj]=='*':
                                count +=1
                    result[i][j] = str(count)

        if field >1:
            output.append("")

        output.append(f"Field #{field}:")
        for row in result:
            output.append("".join(row))

        field += 1

    sys.stdout.write("\n".join(output))

if __name__ == "__main__":
    solve()