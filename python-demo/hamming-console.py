import random

# -------------------------
# HAMMING ENCODER
# -------------------------

def encode(data):

    d1 = int(data[0])
    d2 = int(data[1])
    d3 = int(data[2])
    d4 = int(data[3])

    p1 = d1 ^ d2 ^ d4
    p2 = d1 ^ d3 ^ d4
    p4 = d2 ^ d3 ^ d4

    codeword = [
        p1,
        p2,
        d1,
        p4,
        d2,
        d3,
        d4
    ]

    return codeword


# -------------------------
# FAULT INJECTOR
# -------------------------

def inject_fault(codeword):

    corrupted = codeword.copy()

    fault_position = random.randint(1, 7)

    corrupted[fault_position - 1] ^= 1

    return corrupted, fault_position


# -------------------------
# SYNDROME GENERATOR
# -------------------------

def generate_syndrome(codeword):

    s1 = (
        codeword[0]
        ^ codeword[2]
        ^ codeword[4]
        ^ codeword[6]
    )

    s2 = (
        codeword[1]
        ^ codeword[2]
        ^ codeword[5]
        ^ codeword[6]
    )

    s4 = (
        codeword[3]
        ^ codeword[4]
        ^ codeword[5]
        ^ codeword[6]
    )

    syndrome = (s4 << 2) | (s2 << 1) | s1

    return syndrome


# -------------------------
# CORRECTION UNIT
# -------------------------

def correct_error(codeword, error_position):

    corrected = codeword.copy()

    if error_position != 0:
        corrected[error_position - 1] ^= 1

    return corrected


# -------------------------
# DATA RECOVERY
# -------------------------

def recover_data(codeword):

    data = [
        codeword[2],
        codeword[4],
        codeword[5],
        codeword[6]
    ]

    return ''.join(map(str, data))


# -------------------------
# MAIN PROGRAM
# -------------------------

print("\n======================================")
print(" SELF-HEALING HAMMING DECODER DEMO ")
print("======================================\n")

data = input("Enter 4-bit data: ")

if len(data) != 4 or any(bit not in "01" for bit in data):
    print("\nInvalid Input! Enter exactly 4 bits.")
    exit()

encoded = encode(data)

corrupted, fault_position = inject_fault(encoded)

syndrome = generate_syndrome(corrupted)

corrected = correct_error(corrupted, syndrome)

recovered = recover_data(corrected)

print("\n--------------- RESULTS ----------------")

print("Original Data      :", data)

print("Encoded Codeword   :", ''.join(map(str, encoded)))

print("Fault Injected At  : Bit", fault_position)

print("Corrupted Codeword :", ''.join(map(str, corrupted)))

print("Syndrome           :", format(syndrome, '03b'))

print("Error Position     :", syndrome)

print("Corrected Codeword :", ''.join(map(str, corrected)))

print("Recovered Data     :", recovered)

if recovered == data:
    print("\nSTATUS : SUCCESS ✅")
else:
    print("\nSTATUS : FAILED ❌")

print("-----------------------------------------")
