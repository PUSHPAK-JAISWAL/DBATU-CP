import os
import math.big

fn main() {
	mut fibs := []big.Integer{}
	limit := big.integer_from_string('1'+'0'.repeat(100)) or { big.zero_int }

	mut f1 := big.integer_from_int(1)
	mut f2 := big.integer_from_int(2)

	fibs << f1
	fibs << f2

	for {
		next_f := f1 + f2
		if next_f > limit {
			break
		}

		fibs << next_f
		f1 = f2
		f2 = next_f
	}

	lines := os.get_lines()
	for line in lines {
		parts := line.fields()
		if parts.len < 2 { continue }

		a_str := parts[0]
		b_str := parts[1]

		if a_str == '0' && b_str == '0' {
			break
		}

		a := big.integer_from_string(a_str) or { big.zero_int }
		b := big.integer_from_string(b_str) or { big.zero_int }

		mut count := 0
		for f in fibs {

			if f >= a && f <= b {
				count++
			} else if f>b {
				break
			}

		}
		println(count)
	}
}