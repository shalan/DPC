module MIRROR #(parameter SIZE=32)(
    input   [SIZE-1:0]  in,
    input               m,
    output  [SIZE-1:0]  out 
);
  
    wire [SIZE-1:0] mirror;
    wire [$clog2(SIZE)-1:0] m_buf;

    generate 
        genvar i;
        for(i=0; i<SIZE-1; i=i+1) 
            assign mirror[SIZE-1-i] = in[i];
    endgenerate
    
    generate 
        for(i=0; i<SIZE; i=i+8) begin : BYTE
            sky130_fd_sc_hd__clkbuf_4 SELBUF (.X(m_buf[i/8]), .A(m));
            sky130_fd_sc_hd__mux2_1 M[7:0] (.X(out[i+7:i]), .A0(in[i+7:i]), .A1(mirror[i+7:i]), .S(m_buf[i/8]));
        end
    endgenerate

    
 
endmodule

