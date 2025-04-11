`timescale 1ns / 1ps

module rom (
    input  logic [31:0] addr,
    output logic [31:0] data
);
    logic [31:0] rom[0:32];
    initial begin
        // R,S,L,I타입 롬시나리오
        // //          _funcn7 _rs2  _rs1  _f3 _rd   _opcode;       R_Type
        // rom[0] = 32'b0000000_00001_00010_000_00100_0110011;  //   add x4, x2, x1
        // rom[1] = 32'b0100000_00001_00010_000_00101_0110011;  //   sub x4, x2, x1
        // //          _imm7   _rs2  _rs1  _f3 _imm5   _opcode;     S_Type
        // rom[2] = 32'b0000000_00010_00000_010_01000_0100011; //   sw  x2, 8(ram0);
        // //          _imm7   _imm5 _rs1  _f3 _rd   _opcode;       L_Type
        // rom[3] = 32'b0000000_01000_00000_010_00110_0000011; //   lw  x2, 8(ram0);
        // //          _imm    _shamt_rs1  _f3 _rd   _opcode;       I_Type
        // rom[4] = 32'b1111111_01000_00010_000_00111_0010011; //   
        // rom[5] = 32'b0000000_00001_10110_001_01000_0010011; //   SLLI rs1 << shamt;
        // rom[6] = 32'b0000000_00001_10110_101_01000_0010011; //   SRLI rs1 >> shamt;
        // rom[7] = 32'b0100000_00001_00101_101_01001_0010011; //   SRAI rs1 >>> shamt;
        // rom[8] = 32'b0100000_00001_00111_101_01001_0010011; //   SRAI rs1 >>> shamt;

        // // B타입 롬시나리오: 조건식 검증 alu 출력을 확인   
        // //          _imm7   _rs2  _rs1  _f3 _imm5 _opcode;       B_Type
        // rom[0] = 32'b0000000_00001_00001_000_00010_1100011; //   BEQ rs1 == shamt; 1
        // rom[1] = 32'b0000000_00010_00001_000_00010_1100011; //   BEQ rs1 == shamt; 0

        // rom[2] = 32'b0000000_00001_00001_001_00010_1100011; //   BNE rs1 != shamt; 0
        // rom[3] = 32'b0000000_00010_00001_001_00010_1100011; //   BNE rs1 != shamt; 1

        // rom[4] = 32'b0000000_00001_00001_100_00010_1100011; //   BLT rs1 < shamt; 0
        // rom[5] = 32'b0000000_00010_00001_100_00010_1100011; //   BLT rs1 < shamt; 1
        // rom[6] = 32'b0000000_00001_00010_100_00010_1100011; //   BLT rs1 < shamt; 0

        // rom[7] = 32'b0000000_00001_00001_101_00010_1100011; //   BGE rs1 >= shamt; 1
        // rom[8] = 32'b0000000_00010_00001_101_00010_1100011; //   BGE rs1 >= shamt; 0
        // rom[9] = 32'b0000000_00001_00010_101_00010_1100011; //   BGE rs1 >= shamt; 1

        // rom[10] = 32'b0000000_00001_00001_110_00010_1100011; //  BLTU rs1 < shamt; (U)
        // rom[11] = 32'b0000000_00010_00001_110_00010_1100011; //  BLTU rs1 < shamt; (U)
        // rom[12] = 32'b0000000_00001_00010_110_00010_1100011; //  BLTU rs1 < shamt; (U)

        // rom[13] = 32'b0000000_00001_00001_111_00010_1100011; //  BGEU rs1 >= shamt; (U)
        // rom[14] = 32'b0000000_00010_00001_111_00010_1100011; //  BGEU rs1 >= shamt; (U)
        // rom[15] = 32'b0000000_00001_00010_111_00010_1100011; //  BGEU rs1 >= shamt; (U)

        // //B타입 롬시나리오: imm동작 검증1 romAddr 변화를 확인. 
        // //          _imm7   _rs2  _rs1  _f3 _imm5 _opcode;          B_Type
        // rom[0] = 32'b0000000_00001_00001_000_01000_1100011; //      BEQ rs1 == shamt; 1
        // rom[1] = 32'b0000000_00001_00001_000_00100_1100011; //      BEQ rs1 == shamt; 1 무시되는 롬 데이터
        // rom[2] = 32'b0000000_00010_00001_000_00100_1100011; //      BEQ rs1 == shamt; 0
        // rom[3] = 32'b0000000_00010_00001_000_00100_1100011; //      BEQ rs1 == shamt; 0 롬데이터 4비트(단위길이1)이동
        // rom[4] = 32'b0000000_00001_00001_000_00100_1100011; //      BEQ rs1 == shamt; 1 그냥 TRUE을 위해 넣은 라인

        // // // B타입 롬시나리오
        // //rom[x]=32'b fucn7 _ rs2 _ rs1 _f3 _ rd  _opcode; // R-Type
        // rom[0] = 32'b0000000_00001_00010_000_00100_0110011; // add x4, x2, x1
        // rom[1] = 32'b0100000_00001_00010_000_00101_0110011; // sub x5, x2, x1
        // //rom[x]=32'b imm7  _ rs2 _ rs1 _f3 _ imm5_ opcode; // B-Type
        // rom[2] = 32'b0000000_00010_00010_000_01100_1100011; // beq x2, x2, 12 //2는 PC의 주소
        // //rom[x]=32'b imm7  _ rs2 _ rs1 _f3 _ imm5_ opcode; // S-Type
        // rom[3] = 32'b0000000_00010_00000_010_01000_0100011; // sw x2, 8(x0);
        // //rom[x]=32'b imm12      _ rs1 _f3 _ rd  _ opcode; // L-Type
        // rom[4] = 32'b000000001000_00000_010_00011_0000011; // lw x3, 8(x0);
        // //rom[x]=32'b imm12      _ rs1 _f3 _ rd  _ opcode; // I-Type
        // rom[5] = 32'b000000000001_00000_000_00001_0010011; // addi x1, x0, 1;
        // rom[6] = 32'b000000000010_00001_001_00110_0010011; // slli x6, x1, 2;

        // // // B타입 롬시나리오
        // //           imm20               _rd   _opcode; // R-Type
        // rom[0] = 32'b00000000000000000001_00001_0110111;  // 0
        // rom[1] = 32'b00000000000000000001_00010_0010111;  // 4

        //          _imm      842           _rd   _opcode;       J_Type
        rom[0] = 32'b0_0000000100_0_00000000_11111_1101111;  //   
        // //       _funcn7 _rs2  _rs1  _f3 _rd   _opcode;       R_Type
        rom[1] = 32'b0000000_00001_00010_000_00010_0110011;  //     처음엔 무시 이후에 동작
        //          _imm         _rs1  _000 _rd   _opcode;       JL_Type
        rom[2] = 32'b000000000100_00000_000_11110_1100111; //       rom2로 이동
        // //       _funcn7 _rs2  _rs1  _f3 _rd   _opcode;       R_Type
        rom[4] = 32'b0000000_01101_00010_000_00100_0110011;  //   무시됨


    end
    assign data = rom[addr[31:2]];//0 4 8 16을 0,1,2,3으로 바꿔주기 위해 2비트 시프트
endmodule
