/*************************手撕代码22：仲裁器的设计******************
    function:固定优先级的设计
*/

// 最优设计：使用 req本身与类补码形式的方式（减1再取反）可以得到独热码，且独热码中为1的位为最先出现1的低位。
module fixed_pro_abr #(
    parameter REQ_WIDTH = 16;
) (
    input  logic [REQ_WIDTH-1:0] req,
    output logic [REQ_WIDTH-1:0] grant
);
    assign grant = req & (~(req - 1));
endmodule