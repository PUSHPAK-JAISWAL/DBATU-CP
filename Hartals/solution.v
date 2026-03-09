import os
import strconv

fn read_int() ?int {
	mut word := ''

	for {
		mut buf := []u8{len: 1}

		nread := os.stdin().read(mut buf) or { return none }
		if nread == 0 {
			break
		}

		c := buf[0].ascii_str()
		if c.trim_space() == '' {
			if word != '' {
				break
			}
			continue
		}
		word += c
	}

	if word == '' {
		return none
	}
	
	return strconv.atoi(word) or { return none }
}

fn main() {
	t := read_int() or { return }

	for _ in 0 .. t {
		n := read_int() or { break }
		p := read_int() or { break }

		mut is_strike_day := []bool{len: n + 1, init: false}

		for _ in 0 .. p {
			h := read_int() or { break }

			for day := h; day <= n; day += h {
				is_strike_day[day] = true
			}
		}

		mut lost_days := 0
		for day := 1; day <= n; day++ {
			if is_strike_day[day] {
				mod_7 := day % 7
				if mod_7 != 6 && mod_7 != 0 {
					lost_days++
				}
			}
		}
		println(lost_days)
	}
}