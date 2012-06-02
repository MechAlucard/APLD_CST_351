`timescale 1 ns /100 ps
module dispence_test;
reg			clk;
reg			reset;
reg			gum;
reg			candy;
reg			cookies;
reg			chips;
reg			ack;
reg	[7:0]	coins;
wire		hold;
wire		subtract;
wire		gum_dispence;
wire		candy_dispence;
wire		cookies_dispence;
wire		chips_dispence;
wire		done;
integer		i;

dispence DUT(
.done(done),
.clk(clk),
.reset(reset),
.gum(gum),
.candy(candy),
.cookies(cookies),
.chips(chips),
.coins(coins),
.subtract(subtract),
.gum_dispence(gum_dispence),
.candy_dispence(candy_dispence),
.cookies_dispence(cookies_dispence),
.chips_dispence(chips_dispence),
.ack(ack),
.hold(hold));

 initial begin
 clk = 0;
 reset = 0;
 gum = 0;
 candy = 0;
 cookies = 0;
 chips = 0;
 coins = 0;
 ack = 0;
 i = 0;
 #40;
 end
 always #20 clk = ~clk;
 
 initial begin
 gum = 1;
 for(i=0;i<20;i = i+1)
 begin
	coins = coins + 5;
	#40;
 end
 wait (hold == 1);
 #40;
 ack = 1;
 #40;
 ack = 0;
 wait(subtract == 1);
 gum = 0;
 wait(subtract == 0);
 coins = 0;
 candy = 1;
 for(i=0;i<20;i = i+1)
 begin
	coins = coins + 5;
	#40;
 end
  wait (hold == 1);
 #40;
 ack = 1;
 #40;
 ack = 0;
 candy = 0;
 #40;
 candy = 1;
 for(i=0;i<20;i = i+1)
 begin
	coins = coins + 5;
	#40;
 end
  wait (hold == 1);
 #40;
 ack = 1;
 #40;
 ack = 0;
 wait(subtract == 1);
 candy = 0;
 wait(subtract == 0);
 
 #100;
 reset = 1;
 #100;
 $stop;
 end
 endmodule
