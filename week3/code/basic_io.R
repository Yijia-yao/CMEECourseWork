# Demonstrate the basic input and output operations of R



# Read data (with header)
MyData <- read.csv("week3/data/trees.csv", header = TRUE)


# Write the data as a new CSV file
write.csv(MyData, "../results/MyData.csv")

# Append the first row of the data to the result file
write.table(MyData[1, ], file = "../results/MyData.csv", append = TRUE, col.names = FALSE)

# Retain the line names when exporting
write.csv(MyData, "../results/MyData.csv", row.names = TRUE)

# Ignore the column names when exporting
write.table(MyData, "../results/MyData.csv", col.names = FALSE)


print("The script has been executed！")
