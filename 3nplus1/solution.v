import os

fn cycle_length(mut memo map[u64]u64, n u64) u64 {
	if n == 1 {
		return 1
	}

	if n in memo {
		return memo[n]
	}

	length:= if n%2 == 0 {
		1+ cycle_length(mut memo,n/2)
	} else {
		1+cycle_length(mut memo,3*n+1)
	}

	memo[n] = length
	return length
}

fn main() {
	mut memo:= map[u64]u64{}
	memo[1] = 1

	for {
		line := os.get_raw_line()
		if line.len == 0 {
			break
		}

		parts := line.split(' ')
		if parts.len < 2 {
			continue
		}

		i:= parts[0].u64()
		j:= parts[1].u64()

		start := if i<j {i} else {j}
		end := if j<i {i} else {j}

		mut max_cycle := u64(0)

		for k in start .. end + 1 {
			length := cycle_length(mut memo,k)
			if length > max_cycle {
				max_cycle = length
			}
		}
		println('$i $j $max_cycle')
	}
}