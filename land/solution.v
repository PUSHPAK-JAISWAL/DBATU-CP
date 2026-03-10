import os
import math.big

fn main() {
	lines := os.get_lines()
	if lines.len == 0 {
		return
	}

	mut tokens := []string{}
	for line in lines {
		line_tokens := line.fields()
		for t in line_tokens {
			tokens << t
		}
	}

	if tokens.len == 0 {
		return
	}

	mut idx := 0
	num_tests := tokens[idx].int()
	idx++

	b1 := big.integer_from_int(1)
	b2 := big.integer_from_int(2)
	b3 := big.integer_from_int(3)
	b24 := big.integer_from_int(24)

	for _ in 0 .. num_tests {
		if idx >= tokens.len {
			break
		}

		n_str := tokens[idx]
		idx++

		n := big.integer_from_string(n_str) or { continue }

		if n < b2 {
			println('1')
			continue
		}

		n_m1 := n - b1
		n_m2 := n - b2
		n_m3 := n - b3

		mut term1 := n * n_m1
		term1 = term1 * n_m2
		term1 = term1 * n_m3
		term1 = term1 / b24

		mut term2 := n * n_m1
		term2 = term2 / b2

		result := term1 + term2 + b1
		println(result.str())
	}
}