import os

fn solve() {
	line := os.get_line()
	if line == '' { return }
	num_cases := line.int()
	
	for t in 0 .. num_cases {
		os.get_line() 
		n_str := os.get_line()
		if n_str == '' { continue }
		n := n_str.int()
		
		mut times := []int{len: n}
		for i in 0 .. n {
			times[i] = os.get_line().trim_space().int()
		}
		
		
		times.sort()

		if n == 0 {
			if t < num_cases - 1 { println('') }
			continue
		}

		
		mut total_time := 0
		mut temp_n := n
		for temp_n > 3 {
			a := times[0]
			b := times[1]
			y := times[temp_n - 2]
			z := times[temp_n - 1]
			
			opt1 := b + a + z + b 
			opt2 := z + a + y + a 
			
			if opt1 < opt2 { total_time += opt1 } 
			else { total_time += opt2 }
			temp_n -= 2
		}

		if temp_n == 3 {
			total_time += times[0] + times[1] + times[2]
		} else if temp_n == 2 {
			total_time += times[1]
		} else if temp_n == 1 {
			total_time += times[0]
		}

		println(total_time)

		
		mut cur_n := n
		for cur_n > 3 {
			a := times[0]
			b := times[1]
			y := times[cur_n - 2]
			z := times[cur_n - 1]

			if (b + a + z + b) < (z + a + y + a) {
				println('$a $b')
				println('$a')
				println('$y $z')
				println('$b')
			} else {
				println('$a $z')
				println('$a')
				println('$a $y')
				println('$a')
			}
			cur_n -= 2
		}

		if cur_n == 3 {
			println('${times[0]} ${times[1]}')
			println('${times[0]}')
			println('${times[0]} ${times[2]}')
		} else if cur_n == 2 {
			println('${times[0]} ${times[1]}')
		} else if cur_n == 1 {
			println('${times[0]}')
		}

		if t < num_cases - 1 {
			println('')
		}
	}
}

fn main() {
	solve()
}