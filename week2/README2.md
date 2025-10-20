# Week 2 – Python
This week’s focus was on getting more comfortable with Python — not just writing small scripts, but actually structuring real programs, fixing bugs, and thinking like a programmer.  
It felt like the moment things started “clicking”.

---
###  Coursework Summary
| Task | Description |
|----------|--------------|
| `lc1.py, lc2.py, dictionary.py, tuple.py	` | Practice loops, lists, and comprehensions |
| `cfexercises1.py` | Rewritten as a module with control flows |
| `align_seqs.py` | Aligns DNA sequences and outputs best score |
| `oaks_debugme.py` | Fixed bug in `is_an_oak`, added doctests |


## 1️⃣ Loops, Lists, Tuples, and Dictionaries

The first task was about practicing **loops and list comprehensions**.  
I worked through `lc1.py`, `lc2.py`, `dictionary.py`, and `tuple.py` from *TheMulQuaBio* repo.  

At first, it was repetitive, but after a few exercises I realised that loops, conditionals, and comprehensions are really the foundation of everything else.  
For example, this list comprehension:

```python
[i**2 for i in range(10) if i % 2 == 0]
does the same thing as a full for-loop but is much shorter and cleaner.
```

I also learned about how sets and dictionaries can be built with comprehensions, and how tuples are useful for fixed data.
Once I understood these, the rest of the course material made a lot more sense.

## 2️⃣ Control Flows and Writing Modules

The next part was about control flows — basically, making decisions and structuring programs properly.
We had to turn `cfexercises1.py` into a “module”, similar to `control_flow.py`.
That meant each `foo_x` function had to take arguments, return results, and include test calls like `foo_5(10)` so that the script could run independently.

We also went through examples like:

`if`, `elif`, and `else`

`while` loops (and the danger of infinite loops)

using `break` to exit loops

defining a `main(argv)` function

and ending with the proper Python structure:
```
if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
```
Before this, I didn’t really understand why `__name__ == "__main__" `was needed, but now I get that it lets the file be run both as a program and as a module to import elsewhere.

It felt satisfying to make my code behave like “real” software.

## 3️⃣ Debugging, Testing, and the Oaks Problem

Then came the big one — debugging and unit testing.
We learned to use doctest to test functions automatically by writing test examples directly inside the docstring:
```
def even_or_odd(x):
    """Return whether x is even or odd.

    >>> even_or_odd(2)
    '2 is Even!'
    >>> even_or_odd(3)
    '3 is Odd!'
    """
```
Running `python3 -m doctest -v test_control_flow.py` instantly told us if the function worked as expected.
This was honestly one of the most useful things I’ve learned so far.

We also practiced debugging with `pdb` and `ipdb`, stepping through code line by line and inspecting variables with commands like `p x` or `pp locals()`.
It felt like being inside the code while it ran.

### The “Missing Oaks” Bug

For the `oaks_debugme.py` script, the code wasn’t finding any oaks in the dataset `TestOaksData.csv`.
Using `ipdb` helped me realise that the problem was in the string comparison:
```
return name.lower().startswith('quercs')
```
It was missing a u!
After fixing that typo and improving it to handle small mistakes (like extra spaces or double “s”), it worked properly.

I also added doctests to check cases like:
```
>>> is_an_oak('Quercus robur')
True
>>> is_an_oak('Fagus sylvatica')
False
>>> is_an_oak('Quercuss robur')
False
```
That made the function much more reliable.
This exercise taught me that testing and debugging together save a lot of time in the long run.

## 4️⃣ Aligning DNA Sequences

Another big task was to modify `align_seqs.py`.
Originally it just compared two sequences written inside the code, but I changed it so that it reads them from a CSV file (`DNA_seqs.csv`) and writes the best alignment and score to an output text file (`best_alignment.txt`).

The algorithm loops over all possible alignments and counts how many bases match — the one with the highest score wins.

Example output:
```
Best alignment:
.....CAATTCGGAT
ATCGCCGGATTACGGG

Best score: 5
```

This was my first time making a proper little “bioinformatics tool”.
It uses file I/O, functions, loops, and conditional logic all together — and it actually produces useful output.

### 5️⃣ NumPy and Numerical Computing

Finally, we started using NumPy, which is a game changer for numerical work.
We learned how NumPy arrays differ from Python lists — they’re faster, more efficient, and can handle multidimensional data.

Some basics we practiced:
```
import numpy as np

a = np.arange(5)
b = np.array([[1, 2], [3, 4]])
c = np.ones((2, 3))
d = np.concatenate((a, a))
```
We also explored reshaping (`reshape`, `ravel`), deleting rows, and pre-allocating arrays with zeros or ones.
The logic behind this is that preallocation saves memory and makes computation much faster.

Learning NumPy made me appreciate why Python is so widely used in scientific computing — it can handle huge datasets efficiently, especially compared to normal lists.

---
## 💭 What I Learned

Week 2 was definitely heavier than Week 1, but also much more rewarding.
Here are the main things I’m taking away:

Writing readable and modular code is more important than writing clever code.

Understanding variable scope helps avoid so many hidden bugs.

Debuggers and doctests are powerful — I don’t need a hundred print statements anymore.

Automating input/output makes scripts more reproducible.

NumPy feels like the bridge between programming and real data analysis.

Overall, this week really changed how I think about programming — I’m not just trying to “get it to work”, I’m trying to make it clear, testable, and reliable.

---


Author: Yijia Yao

Email: yijia.yao25@imperial.ac.uk

Course: MSc Computational Methods in Ecology and Evolution

Date: Week 2