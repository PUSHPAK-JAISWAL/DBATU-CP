import os
import math
import strconv

fn main() {
	lines := os.get_lines()

	for line in lines {
		if line.trim_space() == '' { continue }

		parts := line.split(' ')
		if parts.len == 0 { continue }

		n := strconv.atoi(parts[0]) or { continue }

		if n == 1 {
			println('Jolly')
			continue
		}

		mut nums := []int{cap: n}

		for i in 1 .. parts.len {
			if parts[i] != '' {
				nums << strconv.atoi(parts[i]) or { 0 }
			}
		}

		mut found_diffs := []bool { len: n,init: false}
		mut jolly := true

		for i in 0 .. (n-1) {
			diff := int(math.abs(nums[i]-nums[i+1]))

			if diff >= 1 && diff < n && !found_diffs[diff] {
				found_diffs[diff] = true
			} else {
				jolly = false
				break
			}
		}

		if jolly {
			println('Jolly')
		} else {
			println('Not jolly')
		}
	}
}