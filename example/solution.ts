
import * as readline from "readline";

const r1 = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

r1.question("Enter your name: ",(name:string)=> {
    console.log(`Hello, ${name}`);
    r1.close();
})