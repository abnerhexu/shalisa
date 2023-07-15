module SystolicArray(
  input [63:0] a0, a1, a2, a3,
  input [63:0] b0, b1, b2, b3,
  input [3:0] control,
  output [63:0] y00, y01, y02, y03,
  output [63:0] y10, y11, y12, y13,
  output [63:0] y20, y21, y22, y23,
  output [63:0] y30, y31, y32, y33
);
  reg [63:0] a_reg[3:0];
  reg [63:0] b_reg[3:0];
  wire [63:0] p_reg[3:0];
  wire [63:0] a_out_reg[3:0][3:0];
  wire [63:0] b_out_reg[3:0][3:0];
  wire [63:0] y_reg[3:0][3:0];
  wire [3:0] control_reg[3:0][3:0];

  // Generator for PEs
  genvar x, y;
  generate
    for (x = 0; x < 4; x = x + 1) begin : gen_pe
      for (y = 0; y < 4; y = y + 1) begin : gen_pe
        PE pe_inst(
          .a(a_reg[x]),
          .b(b_reg[y]),
          .p(p_reg[y]),
          .control(control_reg[x][y]),
          .y(y_reg[x][y]),
          .a_out(a_out_reg[x][y]),
          .b_out(b_out_reg[x][y])
        );
      end
    end
  endgenerate

  // Connect inputs to registers
  always @* begin
    a_reg[0] = a0;
    a_reg[1] = a1;
    a_reg[2] = a2;
    a_reg[3] = a3;
    b_reg[0] = b0;
    b_reg[1] = b1;
    b_reg[2] = b2;
    b_reg[3] = b3;
    for (x = 0; x < 4; x = x + 1) begin
      for (y = 0; y < 4; y = y + 1) begin
        control_reg[x][y] = control;
      end
    end
  end

  // Data flow and registers for PEs
  always @* begin
    p_reg[0] = 64'd0;
    for (x = 0; x < 4; x = x + 1) begin
      for (y = 1; y < 4; y = y + 1) begin
        a_out_reg[x][y] = a_out_reg[x][y-1];
        b_out_reg[x][y] = b_out_reg[x-1][y];
        y_reg[x][y] = y_reg[x-1][y];
        control_reg[x][y] = control_reg[x-1][y];
      end
      a_out_reg[x][0] = a_reg[x];
      b_out_reg[x][0] = b_reg[0];
      y_reg[x][0] = 0; // Placeholder value for p_in of PE(0, 0)
      control_reg[x][0] = control;
    end
  end

  // Connect outputs from registers
  assign y00 = y_reg[0][0];
  assign y01 = y_reg[0][1];
  assign y02 = y_reg[0][2];
  assign y03 = y_reg[0][3];
  assign y10 = y_reg[1][0];
  assign y11 = y_reg[1][1];
  assign y12 = y_reg[1][2];
  assign y13 = y_reg[1][3];
  assign y20 = y_reg[2][0];
  assign y21 = y_reg[2][1];
  assign y22 = y_reg[2][2];
  assign y23 = y_reg[2][3];
  assign y30 = y_reg[3][0];
  assign y31 = y_reg[3][1];
  assign y32 = y_reg[3][2];
  assign y33 = y_reg[3][3];
endmodule
