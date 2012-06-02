`timescale 1 ns /100 ps
module coin_accepter_test;
reg				clk;
reg				reset;
reg				quarter_in;
reg				dime_in;
reg				nickel_in;
reg				dollar_in;
wire			quarter_add;
wire			dime_add;
wire			nickel_add;
wire			dollar_add;
wire			add;
wire			done;


coin_accepter DUT(
.clk(clk),
.reset(reset),
.quarter_in(quarter_in),
.dime_in(dime_in),
.nickel_in(nickel_in),
.quarter_add(quarter_add),
.dime_add(dime_add),
.nickel_add(nickel_add),
.dollar_add(dollar_add),
.dollar_in(dollar_in),
.done(done),
.add(add));
 always #20 clk = ~clk;
 initial begin
 clk = 0;
 reset = 0;
 quarter_in =0;
 dime_in = 0;
 nickel_in = 0;
 dollar_in = 0;
 #40;

 quarter_in = 1;
 #40;
 wait(quarter_add == 1);
 quarter_in = 0;
 wait(done == 1);
 #40;
 dime_in = 1;
 wait(dime_add == 1);
 dime_in = 0;
 wait(done == 1);
 #40;
 nickel_in = 1;
 wait(nickel_add == 1);
 nickel_in = 0;
 wait(done == 1); 
 #40;
 dollar_in = 1;
 wait(dollar_add == 1);
 dollar_in = 0;
 wait(done == 1); 
 #40;
 quarter_in = 1;
 dime_in = 1;
 nickel_in = 1;
 #100;
 reset = 1;
 #100;
 $stop;
 end
 endmodule
