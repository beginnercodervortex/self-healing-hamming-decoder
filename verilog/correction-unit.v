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
