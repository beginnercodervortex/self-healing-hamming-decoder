module auto_recovery_fsm(

    input clk,
    input rst,
    input illegal,

    output reg [4:0] state,
    output reg error_flag

);

parameter IDLE     = 5'b00001;
parameter SYNDROME = 5'b00010;
parameter CORRECT  = 5'b00100;
parameter VERIFY   = 5'b01000;
parameter OUTPUT   = 5'b10000;

always @(posedge clk or posedge rst)

begin

    if(rst)

    begin
        state <= IDLE;
        error_flag <= 0;
    end

    else if(illegal)

    begin
        state <= IDLE;
        error_flag <= 1;
    end

    else

    begin

        error_flag <= 0;

        case(state)

            IDLE:
                state <= SYNDROME;

            SYNDROME:
                state <= CORRECT;

            CORRECT:
                state <= VERIFY;

            VERIFY:
                state <= OUTPUT;

            OUTPUT:
                state <= IDLE;

            default:
                state <= IDLE;

        endcase

    end

end

endmodule
