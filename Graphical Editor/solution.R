
lines <- readLines("stdin")

M <- 0
N <- 0
grid <- NULL

create <- function(m, n) {
  M <<- m
  N <<- n
  grid <<- matrix("O", nrow = N, ncol = M)
}

clear_table <- function() {
  grid[,] <<- "O"
}

color_pixel <- function(x, y, c) {
  if (x >= 1 && x <= M && y >= 1 && y <= N) {
    grid[y, x] <<- c
  }
}

vertical <- function(x, y1, y2, c) {
  if (x < 1 || x > M) return()
  if (y1 > y2) {
    temp <- y1; y1 <- y2; y2 <- temp
  }
  for (y in y1:y2) {
    if (y >= 1 && y <= N)
      grid[y, x] <<- c
  }
}

horizontal <- function(x1, x2, y, c) {
  if (y < 1 || y > N) return()
  if (x1 > x2) {
    temp <- x1; x1 <- x2; x2 <- temp
  }
  for (x in x1:x2) {
    if (x >= 1 && x <= M)
      grid[y, x] <<- c
  }
}

rectangle_fill <- function(x1, y1, x2, y2, c) {
  if (x1 > x2) {
    temp <- x1; x1 <- x2; x2 <- temp
  }
  if (y1 > y2) {
    temp <- y1; y1 <- y2; y2 <- temp
  }
  for (y in y1:y2) {
    for (x in x1:x2) {
      if (x >= 1 && x <= M && y >= 1 && y <= N)
        grid[y, x] <<- c
    }
  }
}

flood_fill <- function(x, y, c) {
  if (x < 1 || x > M || y < 1 || y > N) return()

  old <- grid[y, x]
  if (old == c) return()

  qy <- c(y)
  qx <- c(x)
  grid[y, x] <<- c

  while (length(qy) > 0) {
    cy <- qy[1]
    cx <- qx[1]
    qy <- qy[-1]
    qx <- qx[-1]

    dirs <- list(c(-1,0), c(1,0), c(0,-1), c(0,1))

    for (d in dirs) {
      ny <- cy + d[1]
      nx <- cx + d[2]

      if (ny >= 1 && ny <= N &&
          nx >= 1 && nx <= M &&
          grid[ny, nx] == old) {
        grid[ny, nx] <<- c
        qy <- c(qy, ny)
        qx <- c(qx, nx)
      }
    }
  }
}

show_image <- function(name) {
  cat(name, "\n", sep = "")
  for (i in 1:N) {
    cat(paste(grid[i, ], collapse=""), "\n", sep = "")
  }
}

for (line in lines) {

  if (nchar(line) == 0) next

  parts <- strsplit(line, " ")[[1]]
  command <- parts[1]

  if (command == "X") break

  if (command == "I") {
    create(as.integer(parts[2]), as.integer(parts[3]))
  } else if (command == "C") {
    clear_table()
  } else if (command == "L") {
    color_pixel(as.integer(parts[2]),
                as.integer(parts[3]),
                parts[4])
  } else if (command == "V") {
    vertical(as.integer(parts[2]),
             as.integer(parts[3]),
             as.integer(parts[4]),
             parts[5])
  } else if (command == "H") {
    horizontal(as.integer(parts[2]),
               as.integer(parts[3]),
               as.integer(parts[4]),
               parts[5])
  } else if (command == "K") {
    rectangle_fill(as.integer(parts[2]),
                   as.integer(parts[3]),
                   as.integer(parts[4]),
                   as.integer(parts[5]),
                   parts[6])
  } else if (command == "F") {
    flood_fill(as.integer(parts[2]),
               as.integer(parts[3]),
               parts[4])
  } else if (command == "S") {
    show_image(parts[2])
  }
}