import tkinter as tk
from tkinter import messagebox
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

    return [
        p1,
        p2,
        d1,
        p4,
        d2,
        d3,
        d4
    ]


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

    s1 = codeword[0] ^ codeword[2] ^ codeword[4] ^ codeword[6]
    s2 = codeword[1] ^ codeword[2] ^ codeword[5] ^ codeword[6]
    s4 = codeword[3] ^ codeword[4] ^ codeword[5] ^ codeword[6]

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

    return ''.join([
        str(codeword[2]),
        str(codeword[4]),
        str(codeword[5]),
        str(codeword[6])
    ])


# -------------------------
# RUN SIMULATION
# -------------------------

def run_simulation():

    data = entry.get().strip()

    if len(data) != 4 or any(bit not in "01" for bit in data):
        messagebox.showerror(
            "Invalid Input",
            "Please enter exactly 4 bits (0 or 1)."
        )
        return

    encoded = encode(data)

    corrupted, fault_position = inject_fault(encoded)

    syndrome = generate_syndrome(corrupted)

    corrected = correct_error(corrupted, syndrome)

    recovered = recover_data(corrected)

    status = "SUCCESS ✅" if recovered == data else "FAILED ❌"

    result_text.set(
        f"""
Original Data      : {data}

Encoded Codeword   : {''.join(map(str, encoded))}

Fault Injected At  : Bit {fault_position}

Corrupted Codeword : {''.join(map(str, corrupted))}

Syndrome           : {format(syndrome, '03b')}

Error Position     : {syndrome}

Corrected Codeword : {''.join(map(str, corrected))}

Recovered Data     : {recovered}

Status             : {status}
"""
    )


# -------------------------
# GUI
# -------------------------

root = tk.Tk()

root.title("Self-Healing Hamming Decoder")

root.geometry("700x500")

title = tk.Label(
    root,
    text="Self-Healing Hamming Decoder",
    font=("Arial", 18, "bold")
)

title.pack(pady=15)

instruction = tk.Label(
    root,
    text="Enter 4-bit Data:"
)

instruction.pack()

entry = tk.Entry(
    root,
    font=("Consolas", 16),
    justify="center"
)

entry.pack(pady=10)

run_button = tk.Button(
    root,
    text="Run Simulation",
    command=run_simulation,
    font=("Arial", 12, "bold")
)

run_button.pack(pady=10)

result_text = tk.StringVar()

result_label = tk.Label(
    root,
    textvariable=result_text,
    justify="left",
    font=("Consolas", 11)
)

result_label.pack(pady=20)

root.mainloop()
