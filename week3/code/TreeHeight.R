# Function: Calculate the tree height based on angles and distances


# Define the function: input the Angle and distance, and output the tree height
TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180  
  height <- distance * tan(radians)
  return(height)
}

# test
print(TreeHeight(30, 10)) 
