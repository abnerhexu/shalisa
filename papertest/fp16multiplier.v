module FP16Multiplier(
  input [15:0] a,
  input [15:0] b,
  output reg [15:0] result
);
  reg [4:0] a_exp, b_exp, result_exp;
  reg [10:0] a_frac, b_frac, result_frac;
  reg [15:0] result_sign;
  reg [0:0] a_sign, b_sign;
  reg is_normalized;

  // Extracting sign, exponent, and fraction for operand A
  assign a_sign = a[15:15];
  assign a_exp = a[14:11];
  assign a_frac = {1'b1, a[10:0]};

  // Extracting sign, exponent, and fraction for operand B
  assign b_sign = b[15:15];
  assign b_exp = b[14:11];
  assign b_frac = {1'b1, b[10:0]};

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
    result_exp = a_exp + b_exp - 15; // Exponent bias is 15
    result_frac = a_frac * b_frac;
    is_normalized = (result_frac[11:10] == 2'b11);

    if (is_normalized) begin
      result_exp = result_exp + 1;
      result_frac = result_frac >> 1;
    end

    result = {result_sign, result_exp, result_frac[10:0]};
  end
endmodule
