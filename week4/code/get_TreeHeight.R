# Read the angles and distances of the tree from the CSV file, calculate the tree height and save the result


args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  input_file <- "../data/trees.csv"
} else {
  input_file <- args[1]
}

if (!file.exists(input_file)) {
  stop(paste("if there is no file：", input_file))
}

trees <- read.csv(input_file)
head(trees)

# read the data
TreeData <- read.csv(input_file, header = TRUE)

# caculate the height of tree（TreeHeight）
TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  return(height)
}

TreeData$Tree.Height.m <- TreeHeight(TreeData$Angle.degrees, TreeData$Distance.m)

# output
output_file <- "../results/TreeHts.csv"
write.csv(TreeData, output_file, row.names = FALSE)

print(paste("The calculation is complete and the result has been saved to：", output_file))
