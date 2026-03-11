import os

fn main() {
	lines := os.get_lines()
	if lines.len == 0 {
		return
	}

	mut tokens := []string{}
	for line in lines {
		tokens << line.fields()
	}

	if tokens.len == 0 {
		return
	}

	mut idx := 0
	num_test_cases := tokens[idx].int()
	idx++

	for _ in 0 .. num_test_cases {
		if idx >= tokens.len {
			break
		}

		num_relatives := tokens[idx].int()
		idx++

		mut streets := []int{cap: num_relatives}
		for _ in 0 .. num_relatives {
			streets << tokens[idx].int()
			idx++
		}

		streets.sort()

		median := streets[num_relatives / 2]

		mut total_distance := 0
		for s in streets {
			diff := s - median
			if diff < 0 {
				total_distance += -diff
			} else {
				total_distance += diff
			}
		}

		println(total_distance)
	}
}