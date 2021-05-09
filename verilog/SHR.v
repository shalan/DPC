module SHR #(parameter SIZE=32)(
    input   [SIZE-1:0]          in,
    input   [$clog2(SIZE)-1:0]  shamt,
    input                       sin,
    output  [SIZE-1:0]          out 
);

    wire[SIZE-1:0] row[$clog2(SIZE):0];
    
    assign row[0] = in;
    assign out = row[$clog2(SIZE)];
    generate 
        genvar i;
        for(i=0; i<$clog2(SIZE); i=i+1) begin : shift_row
            wire [SIZE-1: 0] srow = row[i]; 
            MUXROW R (.in0(srow), .in1({{2**i{sin}}, srow[SIZE-1:2**i]}), .S(shamt[i]), .out(row[i+1]));
        end
    endgenerate

    
endmodule

module MUXROW #(parameter SIZE=32)(
    input   [SIZE-1:0]  in0,
    input   [SIZE-1:0]  in1,
    input               S,
    output  [SIZE-1:0]  out 
);

    wire [$clog2(SIZE)-1:0] S_buf;

    generate 
        genvar i;
        for(i=0; i<SIZE; i=i+8) begin : BYTE
            sky130_fd_sc_hd__clkbuf_4 SBUF (.X(S_buf[i/8]), .A(S));
            sky130_fd_sc_hd__mux2_1 M[7:0] (.X(out[i+7:i]), .A0(in0[i+7:i]), .A1(in1[i+7:i]), .S(S_buf[i/8]));
        end
    endgenerate

endmodule