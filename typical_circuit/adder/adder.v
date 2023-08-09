/************full adder************/

module adder (
    input [1:0] A,
    input [1:0] B,
    input cin,
    output [1:0] S,
    output cout
);
    wire cout_low;
    adder_one_bit add_low(.A(A[0]), .B(B[0]), .cin(cin), .S(S[0]), .cout(cout_low));
    adder_one_bit add_high(.A(A[1]), .B(B[1]), .cin(cout_low), .S(S[1]), .cout(cout));
    
endmodule

module adder_one_bit (
    input A,
    input B,
    input cin,
    output S,
    output cout
);
    assign S = A ^ B ^ cin;
    assign cout = A & B | A & cin | B & cin;
    
endmodule