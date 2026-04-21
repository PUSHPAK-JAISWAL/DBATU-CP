import os

fn solve() {
	for {
		line := os.get_line()
		if line == '' || line == '0 0' {
			break
		}

		parts := line.split(' ')
		if parts.len < 2 { continue }

		mut n1 := parts[0].u64()
		mut n2 := parts[1].u64()
		
		mut carries := 0
		mut current_carry := 0

		
		for n1 > 0 || n2 > 0 {
			d1 := n1 % 10
			d2 := n2 % 10
			
			sum := d1 + d2 + u64(current_carry)
			
			if sum >= 10 {
				carries++
				current_carry = 1
			} else {
				current_carry = 0
			}
			
			n1 /= 10
			n2 /= 10
		}

		
		if carries == 0 {
			println('No carry operation.')
		} else if carries == 1 {
			println('1 carry operation.')
		} else {
			println('$carries carry operations.')
		}
	}
}

fn main() {
	solve()
}