module testbench;

reg [3:0] data;
reg [2:0] fault_position;

wire [6:0] codeword;
wire [6:0] corrupted_codeword;
wire [2:0] syndrome;
wire [2:0] error_position;
wire [6:0] corrected_codeword;
wire [3:0] recovered_data;


// Instantiate DUT

complete_demo uut(

    .data(data),
    .fault_position(fault_position),

    .codeword(codeword),
    .corrupted_codeword(corrupted_codeword),
    .syndrome(syndrome),
    .error_position(error_position),
    .corrected_codeword(corrected_codeword),
    .recovered_data(recovered_data)

);


// Simulation

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0,testbench);

    $display("\n========================================");
    $display(" SELF-HEALING HAMMING DECODER DEMO ");
    $display("========================================");


    // TEST 1

    $display("\n===== TEST 1 =====");

    data = 4'b1011;
    fault_position = 3;

    #20;

    $display("Original Data      = %b", data);
    $display("Encoded Codeword   = %b", codeword);
    $display("Corrupted Codeword = %b", corrupted_codeword);
    $display("Syndrome           = %b", syndrome);
    $display("Error Position     = %d", error_position);
    $display("Corrected Codeword = %b", corrected_codeword);
    $display("Recovered Data     = %b", recovered_data);


    // TEST 2

    $display("\n===== TEST 2 =====");

    data = 4'b1101;
    fault_position = 5;

    #20;

    $display("Original Data      = %b", data);
    $display("Encoded Codeword   = %b", codeword);
    $display("Corrupted Codeword = %b", corrupted_codeword);
    $display("Syndrome           = %b", syndrome);
    $display("Error Position     = %d", error_position);
    $display("Corrected Codeword = %b", corrected_codeword);
    $display("Recovered Data     = %b", recovered_data);


    // TEST 3

    $display("\n===== TEST 3 =====");

    data = 4'b0110;
    fault_position = 1;

    #20;

    $display("Original Data      = %b", data);
    $display("Encoded Codeword   = %b", codeword);
    $display("Corrupted Codeword = %b", corrupted_codeword);
    $display("Syndrome           = %b", syndrome);
    $display("Error Position     = %d", error_position);
    $display("Corrected Codeword = %b", corrected_codeword);
    $display("Recovered Data     = %b", recovered_data);


    // TEST 4

    $display("\n===== TEST 4 =====");

    data = 4'b1111;
    fault_position = 7;

    #20;

    $display("Original Data      = %b", data);
    $display("Encoded Codeword   = %b", codeword);
    $display("Corrupted Codeword = %b", corrupted_codeword);
    $display("Syndrome           = %b", syndrome);
    $display("Error Position     = %d", error_position);
    $display("Corrected Codeword = %b", corrected_codeword);
    $display("Recovered Data     = %b", recovered_data);


    $display("\n========================================");
    $display(" ALL TESTS COMPLETED ");
    $display("========================================");

    #10;
    $finish;

end

endmodule
