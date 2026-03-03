const fs = require("fs");

let input = fs.readFileSync(0, "utf8").trim().split("\n");

let M = 0, N = 0;
let grid = [];

function create(m, n) {
    M = m;
    N = n;
    grid = Array.from({ length: N }, () => Array(M).fill('O'));
}

function clearTable() {
    for (let i = 0; i < N; i++)
        grid[i].fill('O');
}

function colorPixel(x, y, c) {
    if (x >= 1 && x <= M && y >= 1 && y <= N)
        grid[y - 1][x - 1] = c;
}

function vertical(x, y1, y2, c) {
    if (x < 1 || x > M) return;
    if (y1 > y2) [y1, y2] = [y2, y1];

    for (let y = y1; y <= y2; y++)
        if (y >= 1 && y <= N)
            grid[y - 1][x - 1] = c;
}

function horizontal(x1, x2, y, c) {
    if (y < 1 || y > N) return;
    if (x1 > x2) [x1, x2] = [x2, x1];

    for (let x = x1; x <= x2; x++)
        if (x >= 1 && x <= M)
            grid[y - 1][x - 1] = c;
}

function rectangleFill(x1, y1, x2, y2, c) {
    if (x1 > x2) [x1, x2] = [x2, x1];
    if (y1 > y2) [y1, y2] = [y2, y1];

    for (let y = y1; y <= y2; y++) {
        for (let x = x1; x <= x2; x++) {
            if (x >= 1 && x <= M && y >= 1 && y <= N)
                grid[y - 1][x - 1] = c;
        }
    }
}

function floodFill(x, y, c) {
    if (x < 1 || x > M || y < 1 || y > N) return;

    let oldColor = grid[y - 1][x - 1];
    if (oldColor === c) return;

    let queue = [[y - 1, x - 1]];
    grid[y - 1][x - 1] = c;

    let dirs = [[-1,0],[1,0],[0,-1],[0,1]];

    while (queue.length) {
        let [cy, cx] = queue.shift();

        for (let [dy, dx] of dirs) {
            let ny = cy + dy;
            let nx = cx + dx;

            if (ny >= 0 && ny < N && nx >= 0 && nx < M &&
                grid[ny][nx] === oldColor) {
                grid[ny][nx] = c;
                queue.push([ny, nx]);
            }
        }
    }
}

function show(name) {
    console.log(name);
    for (let i = 0; i < N; i++)
        console.log(grid[i].join(""));
}

for (let line of input) {
    if (!line.trim()) continue;

    let parts = line.trim().split(" ");
    let command = parts[0];

    if (command === 'X') break;

    switch (command) {
        case 'I':
            create(parseInt(parts[1]), parseInt(parts[2]));
            break;
        case 'C':
            clearTable();
            break;
        case 'L':
            colorPixel(+parts[1], +parts[2], parts[3]);
            break;
        case 'V':
            vertical(+parts[1], +parts[2], +parts[3], parts[4]);
            break;
        case 'H':
            horizontal(+parts[1], +parts[2], +parts[3], parts[4]);
            break;
        case 'K':
            rectangleFill(+parts[1], +parts[2], +parts[3], +parts[4], parts[5]);
            break;
        case 'F':
            floodFill(+parts[1], +parts[2], parts[3]);
            break;
        case 'S':
            show(parts[1]);
            break;
        default:
            break;
    }
}