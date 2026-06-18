module syndrome_generator(
    input [6:0] codeword,
    output [2:0] syndrome
);

wire s1;
wire s2;
wire s4;

assign s1 = codeword[0] ^ codeword[2] ^ codeword[4] ^ codeword[6];
assign s2 = codeword[1] ^ codeword[2] ^ codeword[5] ^ codeword[6];
assign s4 = codeword[3] ^ codeword[4] ^ codeword[5] ^ codeword[6];

assign syndrome = {s4,s2,s1};

endmodule



module error_locator(
    input [2:0] syndrome,
    output [2:0] error_position
);

assign error_position = syndrome;

endmodule



module correction_unit(
    input [6:0] codeword,
    input [2:0] error_position,
    output reg [6:0] corrected_codeword
);

always @(*) begin

    corrected_codeword = codeword;

    if(error_position != 0)
        corrected_codeword[error_position-1]
            = ~codeword[error_position-1];

end

endmodule



module self_healing_hamming_decoder(
    input [6:0] codeword,
    output [2:0] syndrome,
    output [2:0] error_position,
    output [6:0] corrected_codeword
);

wire [2:0] syndrome_wire;
wire [2:0] error_position_wire;



// Syndrome Generator
syndrome_generator SG(
    .codeword(codeword),
    .syndrome(syndrome_wire)
);



// Error Locator
error_locator EL(
    .syndrome(syndrome_wire),
    .error_position(error_position_wire)
);



// Correction Unit
correction_unit CU(
    .codeword(codeword),
    .error_position(error_position_wire),
    .corrected_codeword(corrected_codeword)
);



// Outputs
assign syndrome = syndrome_wire;
assign error_position = error_position_wire;

endmodule
