#Use "next" to skip the current loop


for (i in 1:10) {
  if ((i %% 2) == 0)  # If it is an even number
    next               # Skip
  print(i)             # Print odd numbers
}

print("next.R Run completed！")
