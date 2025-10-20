# Two example sequences to match
seq2 = "ATCGCCGGATTACGGG"
seq1 = "CAATTCGGAT"


import csv
import sys
import os


input_path = "../data/DNA_seqs.csv"
output_path = "../results/best_alignment.txt"


def read_sequences(filepath):
    """Read two DNA sequences from a CSV file."""
    with open(filepath, "r") as f:
        reader = csv.reader(f)
        seqs = []
        for row in reader:
            # Ignore empty lines or headers
            if len(row) > 0:
                seqs.append(row[1].strip())
        if len(seqs) < 2:
            raise ValueError("Input file must contain at least two sequences!")
    return seqs[0], seqs[1]


def calculate_score(s1, s2, l1, l2, startpoint):
    """Compute alignment score starting from a given offset."""
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]:

                score += 1
    return score


def find_best_alignment(seq1, seq2):
    """Return the best alignment and its score."""
    l1, l2 = len(seq1), len(seq2)
    # Ensure s1 is the longer sequence
    if l1 >= l2:
        s1, s2 = seq1, seq2
    else:
        s1, s2 = seq2, seq1
        l1, l2 = l2, l1

    best_align = None
    best_score = -1

    for i in range(l1):
        z = calculate_score(s1, s2, l1, l2, i)
        if z > best_score:
            best_align = "." * i + s2
            best_score = z
    return best_align, s1, best_score


def main(argv):
    """Main function."""
    print("Reading input sequences...")
    seq1, seq2 = read_sequences(input_path)

    print("Calculating best alignment...")
    best_align, s1, best_score = find_best_alignment(seq1, seq2)

    # Ensure results directory exists
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    print("Saving results...")
    with open(output_path, "w") as out:
        out.write("Best alignment:\n")
        out.write(best_align + "\n")
        out.write(s1 + "\n")
        out.write(f"\nBest score: {best_score}\n")

    print(f"Results saved to: {output_path}")
    print(f"Best score = {best_score}")
    return 0


if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)