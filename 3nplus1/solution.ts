import * as fs from "fs";

const input = fs.readFileSync(0,"utf-8").trim().split("\n");

const memo = new Map<number,number>();
memo.set(1,1);

function cycleLength(n: number): number {
    if(memo.has(n)) return memo.get(n)!;

    let length:number;

    if(n%2===0)
        length = 1+cycleLength(n/2);
    else
        length = 1+cycleLength(3*n+1);

    memo.set(n,length);
    return length;

}

for(const line of input) {
    if(!line.trim()) continue;

    const [iStr,jStr] = line.split(" ");
    const i = parseInt(iStr);
    const j = parseInt(jStr);

    const start = Math.min(i,j);
    const end = Math.max(i,j);

    let maxCycle = 0;

    for(let k = start;k<=end;k++) {
        maxCycle = Math.max(maxCycle,cycleLength(k));
    }

    console.log(`${i} ${j} ${maxCycle}`);
}