module illegal_state_detector(

    input [4:0] state,
    output reg illegal

);

always @(*) begin

    case(state)

        5'b00001: illegal = 0; // IDLE
        5'b00010: illegal = 0; // SYNDROME
        5'b00100: illegal = 0; // CORRECT
        5'b01000: illegal = 0; // VERIFY
        5'b10000: illegal = 0; // OUTPUT

        default: illegal = 1;

    endcase

end

endmodule
