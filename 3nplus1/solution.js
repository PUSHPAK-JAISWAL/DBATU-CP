
var fs = require("fs");
var input = fs.readFileSync(0, "utf-8").trim().split("\n");
var memo = new Map();
memo.set(1, 1);
function cycleLength(n) {
    if (memo.has(n))
        return memo.get(n);
    var length;
    if (n % 2 === 0)
        length = 1 + cycleLength(n / 2);
    else
        length = 1 + cycleLength(3 * n + 1);
    memo.set(n, length);
    return length;
}
for (var _i = 0, input_1 = input; _i < input_1.length; _i++) {
    var line = input_1[_i];
    if (!line.trim())
        continue;
    var _a = line.split(" "), iStr = _a[0], jStr = _a[1];
    var i = parseInt(iStr);
    var j = parseInt(jStr);
    var start = Math.min(i, j);
    var end = Math.max(i, j);
    var maxCycle = 0;
    for (var k = start; k <= end; k++) {
        maxCycle = Math.max(maxCycle, cycleLength(k));
    }
    console.log("".concat(i, " ").concat(j, " ").concat(maxCycle));
}
