module clock_divider(

    input clk,
    input rst,
    output reg scan_clk

);

reg [16:0] count;

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        count <= 17'd0;
        scan_clk <= 1'b0;
    end

    else
    begin

        if(count == 17'd49999)
        begin
            count <= 17'd0;
            scan_clk <= ~scan_clk;
        end

        else
            count <= count + 1'b1;

    end

end

endmodule