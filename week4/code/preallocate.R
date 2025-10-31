# Function: Compare the efficiency of pre-allocation and non-pre-allocation

# The writing style without pre-allocation
NoPreallocFun <- function(x) {
    a <- vector() # empty vector
    for (i in 1:x) {
        a <- c(a, i) # concatenate
        print(a)
        print(object.size(a))
    }
}

system.time(NoPreallocFun(10))

PreallocFun <- function(x) {
    a <- rep(NA, x) # pre-allocated vector
    for (i in 1:x) {
        a[i] <- i # assign
        print(a)
        print(object.size(a))
    }
}

system.time(PreallocFun(10))

print("Unallocated time")
print(system.time(NoPrealloc(10000)))

print("Pre-allocated time")
print(system.time(Prealloc(10000)))
