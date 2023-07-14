module FP64Multiplier(
  input [63:0] a,
  input [63:0] b,
  output reg [63:0] result
);
  reg [1:0] a_exp, b_exp, result_exp;
  reg [51:0] a_frac, b_frac, result_frac;
  reg [12:0] result_sign;
  reg [1:0] a_sign, b_sign;
  reg is_normalized;

  // Extracting sign, exponent, and fraction for operand A
  assign a_sign = a[63:62];
  assign a_exp = a[61:52];
  assign a_frac = {1'b1, a[51:0]};

  // Extracting sign, exponent, and fraction for operand B
  assign b_sign = b[63:62];
  assign b_exp = b[61:52];
  assign b_frac = {1'b1, b[51:0]};

  // Normalize operands if necessary
  always @* begin
    if (a_exp == 0) begin
      a_frac = a_frac << 1;
      a_exp = a_exp + 1;
    end

    if (b_exp == 0) begin
      b_frac = b_frac << 1;
      b_exp = b_exp + 1;
    end
  end

  // Multiplication
  always @* begin
    result_sign = a_sign ^ b_sign;
    result_exp = a_exp + b_exp - 1023; // Exponent bias is 1023
    result_frac = a_frac * b_frac;
    is_normalized = (result_frac[53:52] == 2'b11);

    if (is_normalized) begin
      result_exp = result_exp + 1;
      result_frac = result_frac >> 1;
    end

    result = {result_sign, result_exp, result_frac[51:0]};
  end
endmodule
