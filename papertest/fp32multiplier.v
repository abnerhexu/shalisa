module FP32Multiplier(
  input [31:0] a,
  input [31:0] b,
  output reg [31:0] result
);
  reg [7:0] a_exp, b_exp, result_exp;
  reg [22:0] a_frac, b_frac, result_frac;
  reg [30:0] result_sign;
  reg [0:0] a_sign, b_sign;
  reg is_normalized;

  // Extracting sign, exponent, and fraction for operand A
  assign a_sign = a[31:31];
  assign a_exp = a[30:23];
  assign a_frac = {1'b1, a[22:0]};

  // Extracting sign, exponent, and fraction for operand B
  assign b_sign = b[31:31];
  assign b_exp = b[30:23];
  assign b_frac = {1'b1, b[22:0]};

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
    result_exp = a_exp + b_exp - 127; // Exponent bias is 127
    result_frac = a_frac * b_frac;
    is_normalized = (result_frac[24:23] == 2'b11);

    if (is_normalized) begin
      result_exp = result_exp + 1;
      result_frac = result_frac >> 1;
    end

    result = {result_sign, result_exp, result_frac[22:0]};
  end
endmodule
