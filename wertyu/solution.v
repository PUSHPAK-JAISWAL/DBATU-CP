import os

fn main() {
    
    keys := r"1234567890-=QWERTYUIOP[]\ASDFGHJKL;'ZXCVBNM,./"

    lines := os.get_lines()

    for line in lines {
        mut decoded := ''
        for ch in line {
            if ch == ` ` {
                decoded += ' '
            } else {
                idx := keys.index_u8(ch)
                // If the key is found and isn't the first key of a row
                if idx > 0 {
                    decoded += keys[idx - 1].ascii_str()
                } else {
                    decoded += ch.ascii_str()
                }
            }
        }
        if decoded.len > 0 {
            println(decoded)
        }
    }
}