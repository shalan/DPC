/*
    Note: Use only SIZE=32.
    SLL : sin=0, shl=1
    SRL : sin=0, shl=0
    SRA : sin=A[31], shl=0 
*/

module SHIFTER #(parameter SIZE=32)(
    input   [SIZE-1:0]          in,
    input   [$clog2(SIZE)-1:0]  shamt,
    input                       sin,
    input                       shl,
    output  [SIZE-1:0]          out 
);

    wire [SIZE-1:0] m, mm;
    MIRROR MIN (.in(in), .out(m), .m(shl));
    SHR SR (.in(m), .out(mm), .sin(sin), .shamt(shamt));
    MIRROR MOUT (.in(mm), .out(out), .m(shl));

endmodule