import os

struct Point {
	y int
	x int
}

struct Editor {
mut:
	m    int
	n    int
	grid [][]rune
}


fn (mut e Editor) create(m int, n int) {
	e.m = m
	e.n = n
	e.grid = [][]rune{len: n, init: []rune{len: m, init: `O`}}
}

fn (mut e Editor) clear_table() {
	for i in 0 .. e.n {
		for j in 0 .. e.m {
			e.grid[i][j] = `O`
		}
	}
}

fn (mut e Editor) color_pixel(x int, y int, c rune) {
	if x >= 1 && x <= e.m && y >= 1 && y <= e.n {
		e.grid[y - 1][x - 1] = c
	}
}

fn (mut e Editor) vertical(x int, y1 int, y2 int, c rune) {
	if x < 1 || x > e.m { return }
	mut a, mut b := y1, y2
	if a > b { a, b = b, a }
	for y in a .. b + 1 {
		if y >= 1 && y <= e.n {
			e.grid[y - 1][x - 1] = c
		}
	}
}

fn (mut e Editor) horizontal(x1 int, x2 int, y int, c rune) {
	if y < 1 || y > e.n { return }
	mut a, mut b := x1, x2
	if a > b { a, b = b, a }
	for x in a .. b + 1 {
		if x >= 1 && x <= e.m {
			e.grid[y - 1][x - 1] = c
		}
	}
}

fn (mut e Editor) rectangle_fill(x1 int, y1 int, x2 int, y2 int, c rune) {
	mut a, mut b := x1, x2
	mut c1, mut d := y1, y2
	if a > b { a, b = b, a }
	if c1 > d { c1, d = d, c1 }

	for y in c1 .. d + 1 {
		for x in a .. b + 1 {
			if x >= 1 && x <= e.m && y >= 1 && y <= e.n {
				e.grid[y - 1][x - 1] = c
			}
		}
	}
}

fn (mut e Editor) flood_fill(x int, y int, c rune) {
	if x < 1 || x > e.m || y < 1 || y > e.n { return }

	old := e.grid[y - 1][x - 1]
	if old == c { return }

	mut queue := [Point{y - 1, x - 1}]
	e.grid[y - 1][x - 1] = c

	dirs := [
		Point{-1, 0},
		Point{1, 0},
		Point{0, -1},
		Point{0, 1},
	]

	for queue.len > 0 {
		cur := queue[0]
		queue.delete(0)

		for d in dirs {
			ny := cur.y + d.y
			nx := cur.x + d.x

			if ny >= 0 && ny < e.n && nx >= 0 && nx < e.m && e.grid[ny][nx] == old {
				e.grid[ny][nx] = c
				queue << Point{ny, nx}
			}
		}
	}
}

fn (e Editor) show(name string) {
	println(name)
	for i in 0 .. e.n {
		mut line := ''
		for j in 0 .. e.m {
			line += e.grid[i][j].str()
		}
		println(line)
	}
}

fn main() {
	mut app := Editor{} 
	lines := os.get_raw_lines()

	for line in lines {
		trimmed := line.trim_space()
		if trimmed.len == 0 { continue }

		parts := trimmed.split(' ')
		command := parts[0]

		match command {
			'I' { app.create(parts[1].int(), parts[2].int()) }
			'C' { app.clear_table() }
			'L' { app.color_pixel(parts[1].int(), parts[2].int(), parts[3][0]) }
			'V' { app.vertical(parts[1].int(), parts[2].int(), parts[3].int(), parts[4][0]) }
			'H' { app.horizontal(parts[1].int(), parts[2].int(), parts[3].int(), parts[4][0]) }
			'K' { app.rectangle_fill(parts[1].int(), parts[2].int(), parts[3].int(), parts[4].int(), parts[5][0]) }
			'F' { app.flood_fill(parts[1].int(), parts[2].int(), parts[3][0]) }
			'S' { app.show(parts[1]) }
			'X' { break }
			else {}
		}
	}
}