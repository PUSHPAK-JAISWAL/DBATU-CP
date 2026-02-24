"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var readline = require("readline");
var r1 = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});
r1.question("Enter your name: ", function (name) {
    console.log("Hello, ".concat(name));
    r1.close();
});
