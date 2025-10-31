
# Biological Computing in R
# Author: Yijia.YAO
# Description: Basic R exercises for 2class practice 


# --- Workspace Commands ---
print("### Workspace commands ###")
ls()           # list all variables
getwd()        # get current working directory
# # # setwd("your/path")   # set working directory (uncomment if needed)
# rm(list = ls())      # remove all variables from environment

# --- Basic Arithmetic ---
print("### Arithmetic ###")
a <- 4          # assign variable
print(a)
print(a * a)
a_squared <- a * a
print(a_squared)
print(sqrt(a_squared))  # square root

# --- Vectors ---
print("### Vectors ###")
v <- c(0, 1, 2, 3, 4)
print(v)
print(is.vector(v))
print(mean(v))
print(var(v))
print(median(v))
print(sum(v))
print(prod(v + 1))
print(length(v))

# --- Variable naming conventions ---
print("### Variable naming conventions ###")
wing.width.cm <- 1.2
wing.length.cm <- c(4.7, 5.2, 4.8)
print(wing.width.cm)
print(wing.length.cm)

# Arithmetic
print(3 + 2)
print(7 %/% 3)
print(7 %% 3)
print(2 ^ 4)

# Logical
print(3 > 2)
print(3 <= 2)
print((3 > 2) & (4 > 1))
print((3 > 2) | (1 > 4))
print(!(3 > 2))

#class()is for the view the different type
v <- TRUE
print(v)
print(class(v))

v <- 3.2
print(class(v)) # "numeric"

v <- 2L
print(class(v)) # "integer"

v <- "A string"
print(class(v)) # "character"


print(as.integer(3.1))
print(as.numeric("4"))
print(as.character(155))
print(as.logical(5))  
print(as.logical(0))

print(1e4)   # 1 × 10^4 = 10000
print(5e-2)  # 5 × 10^-2 = 0.05
print(1e4^2) # 1e8 = 100000000
print(1 / 3 / 1e8) # 3.333333e-09






# --- Vector ---
# 向量是同类型数据的一维结构
a <- 5
cat("a <- 5\n")
cat("is.vector(a):", is.vector(a), "\n\n")

# 创建向量
v1 <- c(0.02, 0.5, 1)
v2 <- c("a", "bc", "def", "ghij")
v3 <- c(TRUE, TRUE, FALSE)

cat("v1:", v1, "\n")
cat("v2:", v2, "\n")
cat("v3:", v3, "\n\n")

# 类型自动转换（coercion）
v4 <- c(0.02, TRUE, 1)
cat("v4 <- c(0.02, TRUE, 1):", v4, "\n")

v5 <- c(0.02, "Mary", 1)
cat("v5 <- c(0.02, 'Mary', 1):", v5, "\n\n")

# 创建空向量
v_empty_char <- character(3)
v_empty_num <- numeric(3)
cat("character(3):", v_empty_char, "\n")
cat("numeric(3):", v_empty_num, "\n\n")

# 默认按列填充
mat1 <- matrix(1:25, nrow=5, ncol=5)
cat("matrix(1:25, 5, 5):\n")
print(mat1)

# 按行填充
mat2 <- matrix(1:25, nrow=5, ncol=5, byrow=TRUE)
cat("\nmatrix(1:25, 5, 5, byrow=TRUE):\n")
print(mat2)

# 类型强制转换示例
mat2[1,1] <- "one"
cat("插入字符后矩阵：\n")
print(mat2)
cat("\nmat2 的数据类型变为:", typeof(mat2), "\n\n")


# 创建一个三维数组（两个 5x5 矩阵）
arr1 <- array(1:50, c(5, 5, 2))
cat("array(1:50, c(5,5,2)):\n")

cat("\n第一层（arr1[,,1]）:\n")
print(arr1[,,1])

cat("\n第二层（arr1[,,2]）:\n")
print(arr1[,,2])
cat("\n数组维度 dim(arr1):", dim(arr1), "\n\n")


# --- List --- 
MyList <- list(1L, "p", FALSE, .001) 
MyList
MyList <- list(species=c("Quercus robur","Fraxinus excelsior"), age=c(123, 84))
MyList
MyList[[1]]
MyList[[1]][1]
MyList$species
MyList[["species"]]
MyList$species[1]
pop1<-list(species='Cancer magister',
           latitude=48.3,longitude=-123.1,
           startyr=1980,endyr=1985,
           pop=c(303,402,101,607,802,35))
pop1

pop1<-list(lat=19,long=57,
           pop=c(100,101,99))
pop2<-list(lat=56,long=-120,
           pop=c(1,4,7,7,2,1,2))
pop3<-list(lat=32,long=-10,
           pop=c(12,11,2,1,14))
pops<-list(sp1=pop1,sp2=pop2,sp3=pop3)
pops
pops$sp1
pops$sp1["pop"] # sp1's population sizes
pops[[2]]$lat #latitude of second species
pops[[3]]$pop[3]<-102 #change population of third species at third time step
pops



# --- Data frames数据框可以混合不同类型（类似于表格）  --- 
Col1 <- 1:10
Col1
Col2  <- LETTERS[1:10]
Col2
Col3  <- runif(10)
Col3

MyDF <- data.frame(Col1, Col2, Col3)
MyDF
Print(MyDF)

names(MyDF) <- c("MyFirstColumn", "My Second Column", "My.Third.Column")
MyDF

MyDF$MyFirstColumn
MyDF$My Second Column #It will be error

colnames(MyDF)
colnames(MyDF)[2] <- "MySecondColumn"
MyDF
MyDF$My.Third.Column
MyDF[,1]
MyDF[1,1]
MyDF[c("MyFirstColumn","My.Third.Column")] # show two specific columns only
class(MyDF)
str(MyDF)
head(MyDF)
tail(MyDF)



# --- Matrix vs Dataframe  --- 
MyMat = matrix(1:8, 4, 4)
MyMat
MyDF = as.data.frame(MyMat)
MyDF
object.size(MyMat) 
object.size(MyDF)








# --- Creating and manipulating data  --- 
# --- Creating sequences ---

year  <- 1990:2000
year

years  <-  2009:1990
years

seq(1, 10, 0.5)


# --- Accessing parts of data stuctures: Indices and Indexing ---
MyVar <- c( 'a' , 'b' , 'c' , 'd' , 'e' )
MyVar[1]
MyVar[4]

MyVar[c(3,2,1)] # reverse order
MyVar[c(1,1,5,5)] # repeat indices

v <- c(0, 1, 2, 3, 4) # Create a vector named v
v[3]
v[1:3]
v[-3]
v[c(1, 4)]


mat1 <- matrix(1:25, 5, 5, byrow=TRUE) #create a matrix
mat1
mat1[1,2]
mat1[1,2:4]
mat1[1:2,2:4]
mat1[1,]
mat1[,1]


### --- Recycling ---
a <- c(1,5) + 2
a

x <- c(1,2); y <- c(5,3,9,2)
x;y
x + y
x + c(y,1)


### --- Basic vector-matrix operations ---
v <- c(0, 1, 2, 3, 4)
v2 <- v*2 
v2
v * v2 
t(v)
v %*% t (v)
v3 <- 1:7 # assign using sequence
v3
v4 <- c(v2, v3) # concatenate vectors
v4


### ---Strings and Pasting---
species.name <- "Quercus robur"
species.name
paste("Quercus", "robur")
paste("Quercus", "robur",sep = "") #Get rid of space
paste("Quercus", "robur",sep = ", ") #insert comma to separate
paste('Year is:', 1990:2000)

strsplit("String; to; Split",';')# Split the string at ';'





### --- Generating Random Numbers ---
set.seed(1234567)
rnorm(1)
rnorm(10)
set.seed(1234567)
rnorm(11)


# Define relative base path
base_path <- "MyRCoursework"

# Create main directory (relative to current working directory)
dir.create(base_path, showWarnings = FALSE, recursive = TRUE)

# Create subdirectories
dir.create(file.path(base_path, "code"), showWarnings = FALSE)
dir.create(file.path(base_path, "data"), showWarnings = FALSE)
dir.create(file.path(base_path, "results"), showWarnings = FALSE)

# Confirm structure
list.dirs(base_path, recursive = TRUE)


#Import Mydata

MyData <- read.csv("../data/trees.csv")
ls(pattern = "My*") # Check that MyData has appeared
class(MyData)
head(MyData) # Have a quick look at the data frame
str(MyData) # Note the data types of the three columns

MyData <- read.csv("../data/trees.csv", header = F) # Import ignoring headers
head(MyData)

MyData <- read.table("../data/trees.csv", sep = ',', header = TRUE) #another way
head(MyData)

MyData <- read.csv("../data/trees.csv", skip = 5) # skip first 5 lines




write.csv(MyData, "../results/MyData.csv")
dir("../results/")
write.table(MyData[1,], file = "../results/MyData.csv", append = TRUE)

write.csv(MyData, "../results/MyData.csv", row.names = TRUE)
write.table(MyData, "../results/MyData.csv", col.names = FALSE)


a <- TRUE
if (a == TRUE) {
  print("a is TRUE")
} else {
  print("a is FALSE")
}

if (a) print("a is TRUE")

z <- runif(1)
if (z <= 0.5) {
  print("Less than a half")
}

for (i in 1:10) {
  j <- i * i
  print(paste(i, " squared is", j))
}


for (species in c('Heliodoxa rubinoides', 'Boissonneaua jardini', 'Sula nebouxii')) {
  print(paste('The species is', species))
}

v1 <- c("a", "bc", "def")
for (i in v1) {
  print(i)
}

i <- 0
while (i < 10) {
  i <- i + 1
  print(i^2)
}





