module SystolicArray(
  input [63:0] a0, a1, a2, a3,
  input [63:0] b0, b1, b2, b3,
  output [63:0] y00, y01, y02, y03,
  output [63:0] y10, y11, y12, y13,
  output [63:0] y20, y21, y22, y23,
  output [63:0] y30, y31, y32, y33
);
  wire [63:0] a_in, b_in, p_in;
  wire [63:0] a_out00, a_out01, a_out02, a_out03;
  wire [63:0] a_out10, a_out11, a_out12, a_out13;
  wire [63:0] a_out20, a_out21, a_out22, a_out23;
  wire [63:0] a_out30, a_out31, a_out32, a_out33;
  wire [63:0] b_out00, b_out01, b_out02, b_out03;
  wire [63:0] b_out10, b_out11, b_out12, b_out13;
  wire [63:0] b_out20, b_out21, b_out22, b_out23;
  wire [63:0] b_out30, b_out31, b_out32, b_out33;

  // Instantiate PEs
  PE pe00(
    .a(a_in),
    .b(b_in),
    .p(p_in),
    .control(4'b0000),
    .y(y00),
    .a_out(a_out00),
    .b_out(b_out00)
  );
  PE pe01(
    .a(a_out00),
    .b(b_out01),
    .p(y01),
    .control(4'b0000),
    .y(y01),
    .a_out(a_out01),
    .b_out(b_out01)
  );
  PE pe02(
    .a(a_out01),
    .b(b_out02),
    .p(y02),
    .control(4'b0000),
    .y(y02),
    .a_out(a_out02),
    .b_out(b_out02)
  );
  PE pe03(
    .a(a_out02),
    .b(b_out03),
    .p(y03),
    .control(4'b0000),
    .y(y03),
    .a_out(a_out03),
    .b_out(b_out03)
  );
  PE pe10(
    .a(a_out10),
    .b(b_out10),
    .p(y10),
    .control(4'b0000),
    .y(y10),
    .a_out(a_out10),
    .b_out(b_out10)
  );
  PE pe11(
    .a(a_out11),
    .b(b_out11),
    .p(y11),
    .control(4'b0000),
    .y(y11),
    .a_out(a_out11),
    .b_out(b_out11)
  );
  PE pe12(
    .a(a_out12),
    .b(b_out12),
    .p(y12),
    .control(4'b0000),
    .y(y12),
    .a_out(a_out12),
    .b_out(b_out12)
  );
  PE pe13(
    .a(a_out13),
    .b(b_out13),
    .p(y13),
    .control(4'b0000),
    .y(y13),
    .a_out(a_out13),
    .b_out(b_out13)
  );
  PE pe20(
    .a(a_out20),
    .b(b_out20),
    .p(y20),
    .control(4'b0000),
    .y(y20),
    .a_out(a_out20),
    .b_out(b_out20)
  );
  PE pe21(
    .a(a_out21),
    .b(b_out21),
    .p(y21),
    .control(4'b0000),
    .y(y21),
    .a_out(a_out21),
    .b_out(b_out21)
  );
  PE pe22(
    .a(a_out22),
    .b(b_out22),
    .p(y22),
    .control(4'b0000),
    .y(y22),
    .a_out(a_out22),
    .b_out(b_out22)
  );
  PE pe23(
    .a(a_out23),
    .b(b_out23),
    .p(y23),
    .control(4'b0000),
    .y(y23),
    .a_out(a_out23),
    .b_out(b_out23)
  );
  PE pe30(
    .a(a_out30),
    .b(b_out30),
    .p(y30),
    .control(4'b0000),
    .y(y30),
    .a_out(a_out30),
    .b_out(b_out30)
  );
  PE pe31(
    .a(a_out31),
    .b(b_out31),
    .p(y31),
    .control(4'b0000),
    .y(y31),
    .a_out(a_out31),
    .b_out(b_out31)
  );
  PE pe32(
    .a(a_out32),
    .b(b_out32),
    .p(y32),
    .control(4'b0000),
    .y(y32),
    .a_out(a_out32),
    .b_out(b_out32)
  );
  PE pe33(
    .a(a_out33),
    .b(b_out33),
    .p(y33),
    .control(4'b0000),
    .y(y33),
    .a_out(a_out33),
    .b_out(b_out33)
  );

  // Connect inputs to PEs
  assign a_in = a0;
  assign b_in = b0;
  assign p_in = 64'd0;
  
  // Connect outputs from PEs
  assign a_out00 = pe00.a_out;
  assign a_out01 = pe01.a_out;
  assign a_out02 = pe02.a_out;
  assign a_out03 = pe03.a_out;
  assign a_out10 = pe10.a_out;
  assign a_out11 = pe11.a_out;
  assign a_out12 = pe12.a_out;
  assign a_out13 = pe13.a_out;
  assign a_out20 = pe20.a_out;
  assign a_out21 = pe21.a_out;
  assign a_out22 = pe22.a_out;
  assign a_out23 = pe23.a_out;
  assign a_out30 = pe30.a_out;
  assign a_out31 = pe31.a_out;
  assign a_out32 = pe32.a_out;
  assign a_out33 = pe33.a_out;
  assign b_out00 = pe00.b_out;
  assign b_out01 = pe01.b_out;
  assign b_out02 = pe02.b_out;
  assign b_out03 = pe03.b_out;
  assign b_out10 = pe10.b_out;
  assign b_out11 = pe11.b_out;
  assign b_out12 = pe12.b_out;
  assign b_out13 = pe13.b_out;
  assign b_out20 = pe20.b_out;
  assign b_out21 = pe21.b_out;
  assign b_out22 = pe22.b_out;
  assign b_out23 = pe23.b_out;
  assign b_out30 = pe30.b_out;
  assign b_out31 = pe31.b_out;
  assign b_out32 = pe32.b_out;
  assign b_out33 = pe33.b_out;
endmodule
