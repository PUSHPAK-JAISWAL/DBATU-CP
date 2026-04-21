import os

fn reverse_num(n u64) u64 {
	mut original := n
	mut reversed := u64(0)
	for original > 0 {
		reversed = reversed * 10 + (original % 10)
		original /= 10
	}
	return reversed
}

fn is_palindrome(n u64) bool {
	return n == reverse_num(n)
}

fn solve() {
	line := os.get_line()
	if line == '' {
		return
	}
	n_cases := line.int()

	for _ in 0 .. n_cases {
		mut p := os.get_line().u64()
		mut iterations := 0

		for {
			rev := reverse_num(p)
			p += rev
			iterations++

			if is_palindrome(p) {
				break
			}
		}
		println('$iterations $p')
	}
}

fn main() {
	solve()
}