import os

fn main() {
	mut lines := os.get_raw_lines()
	mut index := 0

	for {
		if index >= lines.len {
			break
		}

		n := lines[index].int()
		index++

		if n==0 {
			break
		}

		mut expenses := []i64{}
		mut total := i64(0)

		for _ in 0 .. n {
			s := lines[index].trim_space()
			index++

			parts := s.split(".")
			dollars := parts[0].i64()
			cents := parts[1].i64()

			value := dollars*100+cents
			expenses << value
			total += value
		}

		avg := total /n

		mut give := i64(0)
		mut take := i64(0)

		for e in expenses {
			if e > avg {
				give += e - avg
			} else {
				take += avg - e
			}
		}

		result := if give > take {give} else {take}

		println("\$${f64(result)/100:.2f}")
	}
}