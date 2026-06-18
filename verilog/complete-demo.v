module hamming_encoder(

    input [3:0] data,
    output [6:0] codeword

);

wire p1;
wire p2;
wire p4;

assign p1 = data[3] ^ data[2] ^ data[0];
assign p2 = data[3] ^ data[1] ^ data[0];
assign p4 = data[2] ^ data[1] ^ data[0];

assign codeword = {
    data[0],
    data[1],
    data[2],
    p4,
    data[3],
    p2,
    p1
};

endmodule



module fault_injector(

    input [6:0] codeword,
    input [2:0] fault_position,

    output reg [6:0] corrupted_codeword

);

always @(*) begin

    corrupted_codeword = codeword;

    if(fault_position != 0)
        corrupted_codeword[fault_position-1]
            = ~codeword[fault_position-1];

end

endmodule



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



module complete_demo(

    input [3:0] data,
    input [2:0] fault_position,

    output [6:0] codeword,
    output [6:0] corrupted_codeword,
    output [2:0] syndrome,
    output [2:0] error_position,
    output [6:0] corrected_codeword,
    output [3:0] recovered_data

);

hamming_encoder ENC(

    .data(data),
    .codeword(codeword)

);

fault_injector FI(

    .codeword(codeword),
    .fault_position(fault_position),
    .corrupted_codeword(corrupted_codeword)

);

syndrome_generator SG(

    .codeword(corrupted_codeword),
    .syndrome(syndrome)

);

error_locator EL(

    .syndrome(syndrome),
    .error_position(error_position)

);

correction_unit CU(

    .codeword(corrupted_codeword),
    .error_position(error_position),
    .corrected_codeword(corrected_codeword)

);

// Extract original 4-bit data

assign recovered_data = {

    corrected_codeword[2],
    corrected_codeword[4],
    corrected_codeword[5],
    corrected_codeword[6]

};

endmodule

