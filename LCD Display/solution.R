
seg <- list(
  c(1,1,1,1,1,1,0), 
  c(0,1,1,0,0,0,0), 
  c(1,1,0,1,1,0,1), 
  c(1,1,1,1,0,0,1), 
  c(0,1,1,0,0,1,1), 
  c(1,0,1,1,0,1,1), 
  c(1,0,1,1,1,1,1), 
  c(1,1,1,0,0,0,0), 
  c(1,1,1,1,1,1,1), 
  c(1,1,1,1,0,1,1)  
)

repeat {
  line <- readLines("stdin", n = 1)
  if (length(line) == 0) break
  
  parts <- strsplit(trimws(line), " ")[[1]]
  s <- as.integer(parts[1])
  n <- as.integer(parts[2])
  
  if (s == 0 && n == 0) break
  
  strn <- as.character(n)
  rows <- 2 * s + 3
  
  for (r in 0:(rows - 1)) {
    row_output <- ""
    
    for (d in 1:nchar(strn)) {
      digit <- as.integer(substr(strn, d, d))
      sg <- seg[[digit + 1]]  
      
      
      if (r == 0) {
        row_output <- paste0(
          row_output, " ",
          if (sg[1] == 1) paste(rep("-", s), collapse="") else paste(rep(" ", s), collapse=""),
          " "
        )
      }
      
      else if (r >= 1 && r <= s) {
        row_output <- paste0(
          row_output,
          if (sg[6] == 1) "|" else " ",
          paste(rep(" ", s), collapse=""),
          if (sg[2] == 1) "|" else " "
        )
      }
      
      else if (r == s + 1) {
        row_output <- paste0(
          row_output, " ",
          if (sg[7] == 1) paste(rep("-", s), collapse="") else paste(rep(" ", s), collapse=""),
          " "
        )
      }
      
      else if (r >= s + 2 && r <= 2 * s + 1) {
        row_output <- paste0(
          row_output,
          if (sg[5] == 1) "|" else " ",
          paste(rep(" ", s), collapse=""),
          if (sg[3] == 1) "|" else " "
        )
      }
      
      else if (r == 2 * s + 2) {
        row_output <- paste0(
          row_output, " ",
          if (sg[4] == 1) paste(rep("-", s), collapse="") else paste(rep(" ", s), collapse=""),
          " "
        )
      }
      
      if (d != nchar(strn)) row_output <- paste0(row_output, " ")
    }
    
    cat(row_output, "\n", sep="")
  }
  
  cat("\n")
}