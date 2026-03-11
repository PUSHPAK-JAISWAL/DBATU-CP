import os


fn flip(mut stack []int, k int) {
	if k <= 1 {
		return
	}
	mut i := 0
	mut j := k - 1
	for i < j {
		
		tmp := stack[i]
		stack[i] = stack[j]
		stack[j] = tmp
		i++
		j--
	}
}

fn main() {
	lines := os.get_lines()
	for line in lines {
		if line.trim_space() == '' {
			continue
		}
		
		
		println(line)

		
		mut stack := []int{}
		fields := line.fields()
		for f in fields {
			stack << f.int()
		}

		mut flips := []int{}
		n := stack.len

	
		for curr_size := n; curr_size > 1; curr_size-- {
			
			mut max_idx := 0
			for i in 0 .. curr_size {
				if stack[i] > stack[max_idx] {
					max_idx = i
				}
			}

			
			if max_idx == curr_size - 1 {
				continue
			}

			
			if max_idx != 0 {
				flip(mut stack, max_idx + 1)
				
				flips << (n - max_idx)
			}

			
			flip(mut stack, curr_size)
			flips << (n - curr_size + 1)
		}

		
		flips << 0
		
		mut result_strs := []string{}
		for f in flips {
			result_strs << f.str()
		}
		println(result_strs.join(' '))
	}
}