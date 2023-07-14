module PE(
  input [63:0] a,
  input [63:0] b,
  input [63:0] p,
  input [3:0] control,
  output reg [63:0] y
);
  wire [31:0] a0, a1, b0, b1, p0, p1;
  wire [31:0] mult_result0, mult_result1;
  wire [63:0] mult_result;

  // Output multiplexer control signals
  reg [1:0] select_ctrl;

  // Instantiate FP32Multiplier modules
  FP32Multiplier multiplier0(
    .a(a[63:32]),
    .b(b[63:32]),
    .result(mult_result0)
  );
  FP32Multiplier multiplier1(
    .a(a[31:0]),
    .b(b[31:0]),
    .result(mult_result1)
  );

  // Instantiate FP64Multiplier module
  FP64Multiplier fp64_multiplier(
    .a(a),
    .b(b),
    .result(mult_result)
  );

  // Splitting inputs for control signal 1
  assign a0 = a[63:32];
  assign a1 = a[31:0];
  assign b0 = b[63:32];
  assign b1 = b[31:0];
  assign p0 = p[63:32];
  assign p1 = p[31:0];

  // PE control logic
  always @(control) begin
    case (control)
      4'b0000: select_ctrl = 2'b00; // Output y = a * b + p
      4'b0001: select_ctrl = 2'b01; // Output y = a0 * b0 + p0, a1 * b1 + p1
      // Add more cases for additional functions in the future
      default: select_ctrl = 2'b00; // Default case, same as above
    endcase
  end

  // Output multiplexer
  always @(select_ctrl, mult_result, mult_result0, mult_result1, p, p0, p1) begin
    case (select_ctrl)
      2'b00: y = mult_result + p; // y = a * b + p
      2'b01: y = {mult_result[63:32] + p[63:32], mult_result[31:0] + p[31:0]}; // y = a0 * b0 + p0, a1 * b1 + p1
      // Add more cases for additional functions in the future
      default: y = mult_result + p; // Default case, same as above
    endcase
  end
endmodule
