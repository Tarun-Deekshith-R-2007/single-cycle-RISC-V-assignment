module alu_control (
    input  logic [2:0] aluop,
    input  logic [2:0] fn3,
    input  logic [6:0] imm11_5,
    input  logic       fn7_5,
    output logic [4:0] alu_control
);

    always_comb begin
        alu_control = 5'b00000;

        case (aluop)

            3'b000: begin
                if (fn3 == 3'b000 && fn7_5)
                    alu_control = 5'b00001;
                else begin
                    case (fn3)
                        3'b000: alu_control = 5'b00000;
                        3'b001: alu_control = 5'b00101;
                        3'b010: alu_control = 5'b01000;
                        3'b011: alu_control = 5'b01001;
                        3'b100: alu_control = 5'b00010;
                        3'b101: alu_control = fn7_5 ? 5'b00111 : 5'b00110;
                        3'b110: alu_control = 5'b00011;
                        3'b111: alu_control = 5'b00100;
                        default: alu_control = 5'b00000;
                    endcase
                end
            end

            3'b001: begin
                case (fn3)
                    3'b000: alu_control = 5'b00000;
                    3'b001: alu_control = 5'b00101;
                    3'b010: alu_control = 5'b01000;
                    3'b011: alu_control = 5'b01001;
                    3'b100: alu_control = 5'b00010;
                    3'b101: alu_control = fn7_5 ? 5'b00111 : 5'b00110;
                    3'b110: alu_control = 5'b00011;
                    3'b111: alu_control = 5'b00100;
                    default: alu_control = 5'b00000;
                endcase
            end

            3'b010, 3'b011, 3'b110: begin
                alu_control = 5'b00000;
            end

            3'b100: begin
                case (fn3)
                    3'b000: alu_control = 5'b01010;
                    3'b001: alu_control = 5'b01011;
                    3'b100: alu_control = 5'b01100;
                    3'b101: alu_control = 5'b01101;
                    3'b110: alu_control = 5'b01110;
                    3'b111: alu_control = 5'b01111;
                    default: alu_control = 5'b00000;
                endcase
            end

            default: alu_control = 5'b00000;

        endcase
    end

endmodule
