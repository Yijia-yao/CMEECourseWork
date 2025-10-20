# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.

high_rain = [(month, rain) for month, rain in rainfall if rain > 100]
print("Step #1:")
print("Months and rainfall values when the amount of rain was greater than 100 mm:")
print(high_rain)
print("\n")

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

low_rain_months = [month for month, rain in rainfall if rain < 50]
print("Step #2:")
print("Months with rainfall less than 50 mm:")
print(low_rain_months)
print("\n")

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

high_rain_loop = []
for month, rain in rainfall:
    if rain > 100:
        high_rain_loop.append((month, rain))

# Rainfall < 50 mm
low_rain_months_loop = []
for month, rain in rainfall:
    if rain < 50:
        low_rain_months_loop.append(month)

print("Step #3:")
print("Using conventional loops:")
print("Months and rainfall values > 100 mm:")
print(high_rain_loop)
print("Months with rainfall < 50 mm:")
print(low_rain_months_loop)

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

