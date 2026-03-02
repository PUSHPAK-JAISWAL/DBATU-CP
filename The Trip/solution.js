const fs = require('fs');

const input = fs.readFileSync(0,"utf8").trim().split('\n');

let index = 0;

while(true) {
    const n = parseInt(input[index++]);
    if(n===0) break;

    let expenses = [];
    let total = 0;

    for(let i = 0;i<n;i++) {
        const amount = parseFloat(input[index++]);
        const cents = Math.round(amount*100);
        expenses.push(cents);
        total += cents;
    }

    const avg = Math.floor(total/n);

    let give = 0;
    let take = 0;

    for(const e of expenses) {
        if(e>avg) {
            give += e-avg;
        } else {
            take += avg-e;
        }
    }
    const result = Math.max(give,take);
    console.log(`$${(result/100).toFixed(2)}`);
}