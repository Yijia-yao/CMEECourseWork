# Python practice for 1class.py
# Author: Yijia.YAO
# Description: Basic Python exercises for 1class practice


# =========================================
# Getting Started with Python
# =========================================

# --- Basic Math Operations ---
print(2 + 2)    # Summation
print(2 * 2)    # Multiplication
print(2 / 2)    # Division
print(2 // 2)   # Integer division
print(2 > 3)    # Logical comparison
print(2 >= 2)   # Logical comparison

# --- Zen of Python ---
import this

# =========================================
# Variable Types
# =========================================

a = 2
print(type(a))

a = 2.0
print(type(a))

a = "Two"
print(type(a))

a = True
print(type(a))

# =========================================
# Operators
# =========================================

print(2 == 2)
print(2 != 2)
print(3 / 2)
print(3 // 2)

x = 5
y = 2
print(x + y)

x = 'My string'
print(x + ' now has more stuff')

# Type conversion
z = '88'
print(x + z)
print(y + int(z))

# =========================================
# Lists
# =========================================

MyList = [3, 2.44, 'green', True]
print(MyList[1])
print(MyList[0])

# Mutating list
MyList[2] = 'blue'
print(MyList)

MyList.append('a new item')
print(MyList)

del MyList[2]
print(MyList)

# =========================================
# Tuples
# =========================================

MyTuple = ("a", "b", "c")
print(MyTuple)
print(type(MyTuple))
print(MyTuple[0])
print(len(MyTuple))

FoodWeb = [('a','b'),('a','c'),('b','c'),('c','c')]
print(FoodWeb)
print(FoodWeb[0])
print(FoodWeb[0][0])

# Immutable example
# FoodWeb[0][0] = "bbb"  # Will cause TypeError

FoodWeb[0] = ("bbb","ccc")
print(FoodWeb)

# =========================================
# Sets
# =========================================

a = [5,6,7,7,7,8,9,9]
b = set(a)
print(b)

c = set([3,4,5,6])
print(b & c)  # Intersection
print(b | c)  # Union

# =========================================
# Dictionaries
# =========================================

GenomeSize = {
    'Homo sapiens': 3200.0,
    'Escherichia coli': 4.6,
    'Arabidopsis thaliana': 157.0
}
print(GenomeSize)

print(GenomeSize['Arabidopsis thaliana'])

GenomeSize['Saccharomyces cerevisiae'] = 12.1
print(GenomeSize)

GenomeSize['Homo sapiens'] = 3201.1
print(GenomeSize)

# Duplicate key example
my_dict = {'a': 1, 'b': 2, 'a': 3}
print(my_dict)

# =========================================
# Copying Mutable Objects
# =========================================

# Reference copy
a = [1, 2, 3]
b = a
a.append(4)
print(a)
print(b)

# Shallow copy
a = [1, 2, 3]
b = a[:]
a.append(4)
print(a)
print(b)

# Deep copy
import copy
a = [[1, 2], [3, 4]]
b = copy.deepcopy(a)
a[0][1] = 22
print(a)
print(b)

# =========================================
# Strings
# =========================================

s = " this is a string "
print(len(s))
print(s.replace(" ","-"))
print(s.find("s"))
print(s.count("s"))
print(s.split())
print(s.split(" is "))
print(s.strip())
print(s.upper())
print(s.upper().strip())
print('WORD'.lower())

# Getting help (use in interactive mode)
# ?s.upper
# help(s.upper)



# ==========================
# loops
# ==========================
# Demonstrates basic for and while loops in Python

# FOR loop example 1
for i in range(5):
    print(i)

# FOR loop example 2
my_list = [0, 2, "geronimo!", 3.0, True, False]
for k in my_list:
    print(k)

# FOR loop example 3
total = 0
summands = [0, 1, 11, 111, 1111]
for s in summands:
    total = total + s
    print(total)

# WHILE loop example
z = 0
while z < 100:
    z = z + 1
    print(z)



# ==========================
# cfexercises1
# ==========================
# Functions demonstrating conditionals (if statements)

def foo_1(x):
    """Return the square root of x."""
    return x ** 0.5


def foo_2(x, y):
    """Return the larger of x and y."""
    if x > y:
        return x
    return y


def foo_3(x, y, z):
    """Return the three inputs sorted in ascending order."""
    if x > y:
        x, y = y, x
    if x > z:
        x, z = z, x
    if y > z:
        y, z = z, y
    return [x, y, z]


def foo_4(x):
    """Return factorial of x using a for loop."""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result


def foo_5(x):
    """Recursive factorial function."""
    if x == 1:
        return 1
    return x * foo_5(x - 1)


def foo_6(x):
    """Factorial using a while loop."""
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto


# Run a few examples
print(foo_1(9))
print(foo_2(3, 9))
print(foo_3(8, 2, 6))
print(foo_4(5))
print(foo_5(5))
print(foo_6(5))



# ==========================
# cfexercises2
# ==========================
# Functions combining loops and conditionals

def hello_1(x):
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')


def hello_2(x):
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')


def hello_3(x, y):
    for i in range(x, y):
        print('hello')
    print(' ')


def hello_4(x):
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')


def hello_5(x):
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')


def hello_6(x, y):
    """Example of while loop with break."""
    while x:  # while x is True
        print("hello! " + str(y))
        y += 1
        if y == 6:
            break
    print(' ')


# Run tests
hello_1(12)
hello_2(12)
hello_3(3, 17)
hello_4(0)
hello_5(12)
hello_6(True, 0)



# ==========================
# oaks
# ==========================
# Finds oak species names using loops and comprehensions

taxa = [
    'Quercus robur',
    'Fraxinus excelsior',
    'Pinus sylvestris',
    'Quercus cerris',
    'Quercus petraea',
]

def is_an_oak(name):
    """Return True if the species name starts with 'Quercus'."""
    return name.lower().startswith('quercus ')

# Using for loop
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)
print("Oaks using for loop:", oaks_loops)

# Using list comprehension
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print("Oaks using list comprehension:", oaks_lc)

# Uppercase names (for loop)
oaks_loops_upper = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops_upper.add(species.upper())
print("Oaks upper (for loop):", oaks_loops_upper)

# Uppercase names (list comprehension)
oaks_lc_upper = set([species.upper() for species in taxa if is_an_oak(species)])
print("Oaks upper (list comprehension):", oaks_lc_upper)


# ==========================
# scope
# ==========================
# Demonstration of variable scope, global variables, and the importance of return
# This script combines all examples discussed.

# ----------------------------------------
# Example 1: Variables in loops (global scope)
# ----------------------------------------
print("\n--- Example 1: Loop variables ---")
i = 1
x = 0
for i in range(10):
    x += 1
print(i)  # 9
print(x)  # 10


# ----------------------------------------
# Example 2: Variables inside a function (local scope)
# ----------------------------------------
print("\n--- Example 2: Local variables in functions ---")
i = 1
x = 0

def a_function(y):
    x = 0  # local variable
    for i in range(y):
        x += 1
    return x

print(a_function(10))  # returns 10
print(i)  # still 1
print(x)  # still 0

# Explicitly replace x
x = a_function(10)
print("New x after catching return value:", x)


# ----------------------------------------
# Example 3: Global variables
# ----------------------------------------
print("\n--- Example 3: Global variables ---")
_a_global = 10  # a global variable

if _a_global >= 5:
    _b_global = _a_global + 5  # also global

print("Before calling a_function, outside:", _a_global, _b_global)

def a_function():
    _a_global = 4  # local variable
    if _a_global >= 4:
        _b_global = _a_global + 5  # local variable
    _a_local = 3

    print("Inside the function, _a_global =", _a_global)
    print("Inside the function, _b_global =", _b_global)
    print("Inside the function, _a_local =", _a_local)

a_function()

print("After calling a_function, outside (still):", _a_global, _b_global)
try:
    print(_a_local)
except NameError:
    print("Error: _a_local is not defined outside the function (NameError)")


# ----------------------------------------
# Example 4: Global variable accessible inside functions
# ----------------------------------------
print("\n--- Example 4: Using global variable inside a function ---")
_a_global = 10

def a_function():
    _a_local = 4
    print("Inside the function, _a_local =", _a_local)
    print("Inside the function, _a_global =", _a_global)

a_function()
print("Outside the function, _a_global =", _a_global)


# ----------------------------------------
# Example 5: Using 'global' keyword
# ----------------------------------------
print("\n--- Example 5: Modifying global variable with 'global' keyword ---")
_a_global = 10
print("Before calling a_function, _a_global =", _a_global)

def a_function():
    global _a_global
    _a_global = 5  # modifies global variable
    _a_local = 4
    print("Inside the function, _a_global =", _a_global)
    print("Inside the function, _a_local =", _a_local)

a_function()
print("After calling a_function, _a_global =", _a_global)


# ----------------------------------------
# Example 6: global in nested function (case 1)
# ----------------------------------------
print("\n--- Example 6a: Nested function using global keyword ---")
def a_function():
    _a_global = 10

    def _a_function2():
        global _a_global
        _a_global = 20

    print("Before calling _a_function2, _a_global =", _a_global)
    _a_function2()
    print("After calling _a_function2, _a_global =", _a_global)

a_function()
print("In main workspace, _a_global =", _a_global)


# ----------------------------------------
# Example 7: global in nested function (case 2)
# ----------------------------------------
print("\n--- Example 6b: Nested function with pre-defined _a_global ---")
_a_global = 10

def a_function():

    def _a_function2():
        global _a_global
        _a_global = 20

    print("Before calling _a_function2, _a_global =", _a_global)
    _a_function2()
    print("After calling _a_function2, _a_global =", _a_global)

a_function()
print("In main workspace, _a_global =", _a_global)


# ----------------------------------------
# Example 8: Return statement importance
# ----------------------------------------
print("\n--- Example 7: Importance of return directive ---")

def modify_list_1(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)

my_list = [1, 2, 3]
print('before, my_list =', my_list)
modify_list_1(my_list)
print('after, my_list =', my_list)  # unchanged

print("\nNow using return...")

def modify_list_2(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)
    return some_list

my_list = [1, 2, 3]
my_list = modify_list_2(my_list)
print('after, my_list =', my_list)

print("\nNow modifying the original list in place...")

def modify_list_3(some_list):
    print('got', some_list)
    some_list.append(4)  # modifies original list object
    print('changed to', some_list)

my_list = [1, 2, 3]
print('before, my_list =', my_list)
modify_list_3(my_list)
print('after, my_list =', my_list)


 




