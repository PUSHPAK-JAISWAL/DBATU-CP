
import os

fn main() {
    
    seg := [
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
    ]

    for {
        line := os.get_raw_line()
        if line.len == 0 {
            break
        }

        parts := line.trim_space().split(' ')
        if parts.len < 2 {
            continue
        }

        s := parts[0].int()
        n := parts[1].int()

        if s == 0 && n == 0 {
            break
        }

        strn := n.str()
        rows := 2 * s + 3

        for r := 0; r < rows; r++ {
            mut row := ''

            for d := 0; d < strn.len; d++ {
                digit := int(strn[d] - `0`)
                sg := seg[digit]

                
                if r == 0 {
                    row += ' '
                    row += if sg[0] == 1 { '-'.repeat(s) } else { ' '.repeat(s) }
                    row += ' '
                }
                
                else if r >= 1 && r <= s {
                    row += if sg[5] == 1 { '|' } else { ' ' }
                    row += ' '.repeat(s)
                    row += if sg[1] == 1 { '|' } else { ' ' }
                }
                
                else if r == s + 1 {
                    row += ' '
                    row += if sg[6] == 1 { '-'.repeat(s) } else { ' '.repeat(s) }
                    row += ' '
                }
                
                else if r >= s + 2 && r <= 2 * s + 1 {
                    row += if sg[4] == 1 { '|' } else { ' ' }
                    row += ' '.repeat(s)
                    row += if sg[2] == 1 { '|' } else { ' ' }
                }
                
                else if r == 2 * s + 2 {
                    row += ' '
                    row += if sg[3] == 1 { '-'.repeat(s) } else { ' '.repeat(s) }
                    row += ' '
                }

                if d != strn.len - 1 {
                    row += ' '
                }
            }

            println(row)
        }

        println('')
    }
}