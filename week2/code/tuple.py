birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by
# species 
# 
# A nice example output is:
# 
# Latin name: Passerculus sandwichensis Common name: Savannah sparrow Mass: 18.7
# ... etc.

# ---------- Method 1: Single-line printing ----------
print("Step 1: Single-line output\n")
for latin, common, mass in birds:
    print(f"Latin name: {latin} | Common name: {common} | Mass: {mass}")

# ---------- Method 2: Print in separate lines ----------
print("\nStep 2: Multi-line formatted output\n")
for latin, common, mass in birds:
    print(f"Latin name: {latin}")
    print(f"Common name: {common}")
    print(f"Mass: {mass}\n")