module error_locator(
    input [2:0] syndrome,
    output [2:0] error_position
);

assign error_position = syndrome;

endmodule
