solve <- function() {
  input <- readLines("stdin")
  idx <- 1
  field <- 1
  output <- c()
  
  while (TRUE) {
    parts <- strsplit(input[idx], " ")[[1]]
    idx <- idx + 1
    
    n <- as.integer(parts[1])
    m <- as.integer(parts[2])
    
    if (n == 0 && m == 0) break
    
    grid <- matrix("", n, m)
    
    for (i in 1:n) {
      row_chars <- strsplit(input[idx], "")[[1]]
      grid[i, ] <- row_chars
      idx <- idx + 1
    }
    
    result <- matrix("0", n, m)
    
    for (i in 1:n) {
      for (j in 1:m) {
        
        if (grid[i, j] == "*") {
          result[i, j] <- "*"
        } else {
          count <- 0
          
          for (dx in -1:1) {
            for (dy in -1:1) {
              
              if (dx == 0 && dy == 0) next
              
              ni <- i + dx
              nj <- j + dy
              
              if (ni >= 1 && ni <= n && nj >= 1 && nj <= m) {
                if (grid[ni, nj] == "*") {
                  count <- count + 1
                }
              }
            }
          }
          
          result[i, j] <- as.character(count)
        }
      }
    }
    
    if (field > 1) {
      output <- c(output, "")
    }
    
    output <- c(output, paste0("Field #", field, ":"))
    
    for (i in 1:n) {
      output <- c(output, paste(result[i, ], collapse=""))
    }
    
    field <- field + 1
  }
  
  cat(paste(output, collapse="\n"))
}

solve()