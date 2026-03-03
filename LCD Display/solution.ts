
import * as fs from "fs";

const input = fs.readFileSync(0, "utf8").trim().split("\n");

const seg: number[][] = [
  [1,1,1,1,1,1,0], 
  [0,1,1,0,0,0,0], 
  [1,1,0,1,1,0,1], 
  [1,1,1,1,0,0,1], 
  [0,1,1,0,0,1,1], 
  [1,0,1,1,0,1,1], 
  [1,0,1,1,1,1,1], 
  [1,1,1,0,0,0,0], 
  [1,1,1,1,1,1,1], 
  [1,1,1,1,0,1,1], 
];

let output: string[] = [];

for (let line of input) {
  const [sStr, nStr] = line.trim().split(" ");
  const s = Number(sStr);
  const n = Number(nStr);

  if (s === 0 && n === 0) break;

  const str = n.toString();
  const rows = 2 * s + 3;

  for (let r = 0; r < rows; r++) {
    let row = "";

    for (let d = 0; d < str.length; d++) {
      const digit = Number(str[d]);

      
      if (r === 0) {
        row += " " + (seg[digit][0] ? "-".repeat(s) : " ".repeat(s)) + " ";
      }
      
      else if (r >= 1 && r <= s) {
        row += (seg[digit][5] ? "|" : " ");
        row += " ".repeat(s);
        row += (seg[digit][1] ? "|" : " ");
      }
      
      else if (r === s + 1) {
        row += " " + (seg[digit][6] ? "-".repeat(s) : " ".repeat(s)) + " ";
      }
      
      else if (r >= s + 2 && r <= 2 * s + 1) {
        row += (seg[digit][4] ? "|" : " ");
        row += " ".repeat(s);
        row += (seg[digit][2] ? "|" : " ");
      }
      
      else if (r === 2 * s + 2) {
        row += " " + (seg[digit][3] ? "-".repeat(s) : " ".repeat(s)) + " ";
      }

      if (d !== str.length - 1) row += " ";
    }

    output.push(row);
  }

  output.push(""); 
}

console.log(output.join("\n"));