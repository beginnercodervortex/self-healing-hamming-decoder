module syndrome_generator(
    input [6:0] codeword,
    output [2:0] syndrome
);

wire s1;
wire s2;
wire s4;

// P1 checks positions 1,3,5,7
assign s1 = codeword[0] ^ codeword[2] ^ codeword[4] ^ codeword[6];

// P2 checks positions 2,3,6,7
assign s2 = codeword[1] ^ codeword[2] ^ codeword[5] ^ codeword[6];

// P4 checks positions 4,5,6,7
assign s4 = codeword[3] ^ codeword[4] ^ codeword[5] ^ codeword[6];

assign syndrome = {s4,s2,s1};

endmodule
