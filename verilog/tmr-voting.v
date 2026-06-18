module tmr_majority_voter(

    input [2:0] synA,
    input [2:0] synB,
    input [2:0] synC,

    output [2:0] voted_syndrome

);

assign voted_syndrome =
        (synA & synB) |
        (synB & synC) |
        (synA & synC);

endmodule
