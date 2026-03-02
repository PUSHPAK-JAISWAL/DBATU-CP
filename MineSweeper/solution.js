const fs = require("fs");

function solve() {
    const input = fs.readFileSync(0, "utf8").trim().split("\n");
    let idx = 0;
    let field = 1;
    const output = [];

    while (true) {
        const [nStr, mStr] = input[idx++].split(" ");
        const n = Number(nStr);
        const m = Number(mStr);

        if (n === 0 && m === 0) break;

        const grid = [];
        for (let i = 0; i < n; i++) {
            grid.push(input[idx++]);
        }

        const result = [];

        for (let i = 0; i < n; i++) {
            let row = "";
            for (let j = 0; j < m; j++) {
                if (grid[i][j] === "*") {
                    row += "*";
                } else {
                    let count = 0;

                    for (let dx = -1; dx <= 1; dx++) {
                        for (let dy = -1; dy <= 1; dy++) {
                            if (dx === 0 && dy === 0) continue;

                            const ni = i + dx;
                            const nj = j + dy;

                            if (
                                ni >= 0 && ni < n &&
                                nj >= 0 && nj < m &&
                                grid[ni][nj] === "*"
                            ) {
                                count++;
                            }
                        }
                    }

                    row += count;
                }
            }
            result.push(row);
        }

        if (field > 1) output.push("");
        output.push(`Field #${field}:`);
        output.push(...result);

        field++;
    }

    console.log(output.join("\n"));
}

solve();