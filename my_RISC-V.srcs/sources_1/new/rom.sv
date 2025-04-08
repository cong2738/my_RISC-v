`timescale 1ns / 1ps

module rom (
    input  logic [31:0] addr,
    output logic [31:0] data
);
    logic [31:0] rom[0:15];
    initial begin
        //           _funcn7 _rs2  _rs1  _f3 _rd   _opcode;
        rom[0]  = 32'b0000000_00001_00010_000_11111_0110011;  //add  rd, rs2, rs1 | x31 = x1+x2     31
        rom[1]  = 32'b0100000_00001_00010_000_11110_0110011;  //sub  rd, rs2, rs1 | x30 = x1-x2     30
        rom[2]  = 32'b0000000_11110_11110_000_11101_0110011;  //sub  rd, rs2, rs1 | x30 = x1-x2     29
        rom[3]  = 32'b0000000_11110_11101_001_11100_0110011;  //sll  rd, rs2, rs1 | x29 = x1<<x2    28
        rom[4]  = 32'b0000000_11110_11101_101_11011_0110011;  //srl  rd, rs2, rs1 | x28 = x1>>x2    27
        rom[5]  = 32'b0100000_11110_11110_101_11010_0110011;  //sra  rd, rs2, rs1 | x27 = x1>>>x2   26
        rom[6]  = 32'b0000000_00001_00010_010_11001_0110011;  //slt  rd, rs2, rs1 | x26 = x1<x2     25
        rom[7]  = 32'b0000000_00001_00010_011_11000_0110011;  //sltU rd, rs2, rs1 | x25 = x1<x2 (U) 24
        rom[8]  = 32'b0000000_00001_00010_100_10111_0110011;  //xor  rd, rs2, rs1 | x24 = x1^x2     23
        rom[9]  = 32'b0000000_00001_00010_110_10110_0110011;  //or   rd, rs2, rs1 | x23 = x1|x2     22
        rom[10] = 32'b0000000_00001_00010_111_10101_0110011;  //and  rd, rs2, rs1 | x22 = x1&x2     21
        rom[11] = 32'b0100000_11110_00000_000_10100_0110011;  //sub  rd, rs2, rs1 | x30 = x1+x2     20
        rom[12] = 32'b0000000_11110_10100_101_10011_0110011;  //srl  rd, rs2, rs1 | x30 = x1>>x2    19
        rom[13] = 32'b0000000_10011_10100_010_10010_0110011;  //sra  rd, rs2, rs1 | x30 = x1<x2     18
    end
    assign data = rom[addr[31:2]];//0 4 8 16을 0,1,2,3으로 바꿔주기 위해 2비트 시프트

    //브랜치테스트
endmodule
