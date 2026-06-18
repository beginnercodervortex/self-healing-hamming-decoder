module fsm_controller(

    input clk,
    input rst,

    output reg [4:0] state

);

parameter IDLE     = 5'b00001;
parameter SYNDROME = 5'b00010;
parameter CORRECT  = 5'b00100;
parameter VERIFY   = 5'b01000;
parameter OUTPUT   = 5'b10000;

always @(posedge clk or posedge rst)

begin

    if(rst)

        state <= IDLE;

    else

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

endmodule
