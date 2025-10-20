
import sys

def foo_1(x):
    """Return the square root of x."""
    return x ** 0.5

def foo_2(x, y):
    """Return the larger of x and y."""
    if x > y:
        return x
    else:
        return y

def foo_3(x, y, z):
    """Return x, y, z in ascending order."""
    return sorted([x, y, z])

def foo_4(x):
    """Return factorial of x (x!)."""
    result = 1
    for i in range(1, x + 1):
        result *= i
    return result

def foo_5(x):
    """Return a list of Fibonacci numbers up to x."""
    fibs = [0, 1]
    for i in range(2, x):
        fibs.append(fibs[-1] + fibs[-2])
    return fibs[:x]

def main(argv):
    """Main entry point."""
    print("foo_1(9) =", foo_1(9))
    print("foo_2(10, 20) =", foo_2(10, 20))
    print("foo_3(10, 5, 7) =", foo_3(10, 5, 7))
    print("foo_4(5) =", foo_4(5))
    print("foo_5(10) =", foo_5(10))
    return 0

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
