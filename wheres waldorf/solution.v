import os


const dr = [-1, -1, -1, 0, 0, 1, 1, 1]
const dc = [-1, 0, 1, -1, 1, -1, 0, 1]

fn solve() {
    mut line := os.get_line()
    if line == '' { return }
    
    num_cases := line.trim_space().int()
    
    for t in 0 .. num_cases {
        os.get_line() 
        
        dims := os.get_line().split(' ')
        if dims.len < 2 { continue }
        m := dims[0].int()
        n := dims[1].int()
        
        mut grid := []string{len: m}
        for i in 0 .. m {
            grid[i] = os.get_line().trim_space().to_lower()
        }
        
        num_words := os.get_line().trim_space().int()
        for _ in 0 .. num_words {
            word := os.get_line().trim_space().to_lower()
            find_word(grid, m, n, word)
        }
        
        if t < num_cases - 1 {
            println('')
        }
    }
}

fn find_word(grid []string, m int, n int, word string) {
    
    for r in 0 .. m {
        for c in 0 .. n {
            if grid[r][c] == word[0] {
                for d in 0 .. 8 {
                    if check(grid, m, n, word, r, c, d) {
                        println('${r + 1} ${c + 1}')
                        return
                    }
                }
            }
        }
    }
}

fn check(grid []string, m int, n int, word string, r int, c int, dir int) bool {
    for i in 0 .. word.len {
        nr := r + (dr[dir] * i)
        nc := c + (dc[dir] * i)
        
        if nr < 0 || nr >= m || nc < 0 || nc >= n || grid[nr][nc] != word[i] {
            return false
        }
    }
    return true
}

fn main() {
    solve()
}