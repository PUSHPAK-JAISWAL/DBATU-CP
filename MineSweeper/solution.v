import os

fn main() {
    mut field := 1

    for {
        line := os.get_line()
        if line.len == 0 {
            break
        }

        parts := line.split(' ')
        n := parts[0].int()
        m := parts[1].int()

        if n == 0 && m == 0 {
            break
        }

        mut grid := [][]rune{}
        for _ in 0 .. n {
            row := os.get_line().runes()
            grid << row
        }

        mut result := [][]rune{len: n, init: []rune{len: m, init: `0`}}

        for i in 0 .. n {
            for j in 0 .. m {

                if grid[i][j] == `*` {
                    result[i][j] = `*`
                } else {
                    mut count := 0

                    for dx in -1 .. 2 {
                        for dy in -1 .. 2 {

                            if dx == 0 && dy == 0 {
                                continue
                            }

                            ni := i + dx
                            nj := j + dy

                            if ni >= 0 && ni < n && nj >= 0 && nj < m {
                                if grid[ni][nj] == `*` {
                                    count++
                                }
                            }
                        }
                    }

                    result[i][j] = rune(count + `0`)
                }
            }
        }

        if field > 1 {
            println("")
        }

        println("Field #${field}:")
        for i in 0 .. n {
            println(result[i].string())
        }

        field++
    }
}