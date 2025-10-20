import csv
import sys

#Define function
#def is_an_oak(name):
#  """ Returns True if name is starts with 'quercus' """
#return name.lower().startswith('quercs')

###Spelling mistake: 'quercs' is missing a u

def is_an_oak(name):
    """Returns True if name starts with 'quercus'"""
    return name.lower().startswith('quercus')



#def main(argv): 
    #f = open('../data/TestOaksData.csv','r')
    #g = open('../data/JustOaksData.csv','w')
    #taxa = csv.reader(f)
    #csvwrite = csv.writer(g)
    #oaks = set()
    #for row in taxa:
        #print(row)
        #print ("The genus is: ") 
        #print(row[0] + '\n')
        #if is_an_oak(row[0]):
            #print('FOUND AN OAK!\n')
            #csvwrite.writerow([row[0], row[1]])    

    #return 0
    
#if (__name__ == "__main__"):
    #status = main(sys.argv)

###If you input "Quercuss" (with an extra "s") or "Quercus robur" (with a space), the original function will wrongly return False. So we need to: automatically remove Spaces; Ignore case; Minor spelling mistakes (such as Quercuss) are allowed

def main(argv): 
    """Reads a CSV file, writes a new one with only oaks."""
    with open('../data/TestOaksData.csv','r') as f, open('../results/JustOaksData.csv','w', newline='') as g:
        taxa = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in taxa:
            print(row)
            print("The genus is:", row[0])
            if is_an_oak(row[0]):
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])
    return 0

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)