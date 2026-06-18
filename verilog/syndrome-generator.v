module testbench;

reg [6:0] codeword;
wire [2:0] syndrome;

syndrome_generator uut (
    .codeword(codeword),
    .syndrome(syndrome)
);

initial begin

    $display("------TEST 1------");

    codeword = 7'b0110111;;

    #10;

    $display("Codeword = %b", codeword);
    $display("Syndrome = %b", syndrome);

end

endmodule
