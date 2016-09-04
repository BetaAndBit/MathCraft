#
# A usefull function

addBlock <- function(x, y, z, b, conn) {
  writeLines(paste0("world.setBlock(",round(x),",",round(y),",",round(z),",",round(b),")"), conn)
}

#
# Connect to the server (install and run https://www.nostarch.com/download/LTPWM_ch01_update_online.pdf)

conn <- socketConnection(host="localhost", port = 4711, blocking=TRUE, server=FALSE, open="r+")
baseline <- 70

#
# Add two layers of grass and wipe out everything above

writeLines(paste0("world.setBlocks(-80,",baseline-2,",-80,180,",baseline,",180,2)"), conn)
writeLines(paste0("world.setBlocks(-50,",baseline+1,",-50,150,",baseline+50,",150,0)"), conn)

#
# And now add blocks based on iris data

for (i in 1:nrow(iris)) {
  addBlock(10*iris[i,"Sepal.Length"],
           baseline + 2 + 10*(iris[i,"Sepal.Width"] - min(iris[,"Sepal.Width"])),
           10*iris[i,"Petal.Length"],
           c(41,42,45)[as.numeric(iris[i,"Species"])], 
           conn)
}
