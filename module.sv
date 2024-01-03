module Tetris(output reg [7:0] DATA_R, DATA_G, DATA_B,
            output reg [3:0] COMM,
				output reg [6:0] seg,
				output reg [7:0] count_out,
				output reg [3:0] seg_cnt,
				output[2:0]light,
				output beep,
            input left,right,reset,shoot,
            input CLK);
reg [2:0] position;    //character's position
bit [3:0] a,b,c,d,e,f,g,h;
bit [7:0] a_move [7:0];
bit [7:0] b_move [7:0];
bit [7:0] c_move [7:0];
bit [7:0] d_move [7:0];
bit [7:0] e_move [7:0];
bit [7:0] f_move [7:0];
bit [7:0] g_move [7:0];
bit [7:0] h_move [7:0];
reg [7:0] count;
bit [2:0] cnt;
reg [2:0] gameover;
reg [1:0] shine;
reg [11:0] life;
bit [7:0] rnd,count_rand;
bit [3:0] a_shoot,b_shoot,c_shoot,d_shoot,e_shoot,f_shoot,g_shoot,h_shoot;
bit [7:0] a_s_move [7:0]; 
bit [7:0] b_s_move [7:0];
bit [7:0] c_s_move [7:0];
bit [7:0] d_s_move [7:0];
bit [7:0] e_s_move [7:0];
bit [7:0] f_s_move [7:0];
bit [7:0] g_s_move [7:0];
bit [7:0] h_s_move [7:0];
bit [3:0] s_index;
integer flag_ab,flag_cd,flag_ef,flag_gh;
reg       a_reset,b_reset,c_reset,d_reset,e_reset,f_reset,g_reset,h_reset;
//counter
reg [3:0] index [3:0];
reg [3:0] A_count;
reg [3:0] C1_count;
reg [3:0] C2_count;
reg [3:0] C3_count;
reg [3:0] C4_count;
reg [2:0] seg_count;
reg [1:0] count_ab;
reg [1:0] count_cd;
reg [1:0] count_ef;
reg [1:0] count_gh;


parameter logic [7:0] X0 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b01111111};
parameter logic [7:0] X1 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b01111111,
			8'b11111111};
parameter logic [7:0] X2 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b01111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] X3 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b01111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] X4 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b01111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] X5 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b01111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] X6 [7:0]='{
         8'b11111111,
			8'b01111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] X7 [7:0]='{
         8'b01111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] a0 [7:0]='{
         8'b11111110,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] a1 [7:0]='{
         8'b11111101,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] a2 [7:0]='{
         8'b11111011,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] a3 [7:0]='{
         8'b11110111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] a4 [7:0]='{
         8'b11101111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] a5 [7:0]='{
         8'b11011111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] a6 [7:0]='{
         8'b10111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] a7 [7:0]='{
         8'b01111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] b0 [7:0]='{
         8'b11111111,
			8'b11111110,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] b1 [7:0]='{
         8'b11111111,
			8'b11111101,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] b2 [7:0]='{
         8'b11111111,
			8'b11111011,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] b3 [7:0]='{
         8'b11111111,
			8'b11110111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] b4 [7:0]='{
         8'b11111111,
			8'b11101111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] b5 [7:0]='{
         8'b11111111,
			8'b11011111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] b6 [7:0]='{
         8'b11111111,
			8'b10111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] b7 [7:0]='{
         8'b11111111,
			8'b01111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] c0 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111110,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] c1 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111101,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] c2 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111011,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] c3 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11110111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] c4 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11101111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] c5 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11011111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] c6 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b10111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] c7 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b01111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] d0 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111110,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] d1 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111101,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] d2 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111011,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] d3 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11110111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] d4 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11101111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] d5 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11011111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] d6 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b10111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] d7 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b01111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] e0 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111110,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] e1 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111101,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] e2 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111011,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] e3 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11110111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] e4 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11101111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] e5 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11011111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] e6 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b10111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] e7 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b01111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] f0 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111110,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] f1 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111101,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] f2 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111011,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] f3 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11110111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] f4 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11101111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] f5 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11011111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] f6 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b10111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] f7 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b01111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] g0 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111110,
			8'b11111111};
parameter logic [7:0] g1 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111101,
			8'b11111111};
parameter logic [7:0] g2 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111011,
			8'b11111111};
parameter logic [7:0] g3 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11110111,
			8'b11111111};
parameter logic [7:0] g4 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11101111,
			8'b11111111};
parameter logic [7:0] g5 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11011111,
			8'b11111111};
parameter logic [7:0] g6 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b10111111,
			8'b11111111};
parameter logic [7:0] g7 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b01111111,
			8'b11111111};
parameter logic [7:0] h0 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111110};
parameter logic [7:0] h1 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111101};
parameter logic [7:0] h2 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111011};
parameter logic [7:0] h3 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11110111};
parameter logic [7:0] h4 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11101111};
parameter logic [7:0] h5 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11011111};
parameter logic [7:0] h6 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b10111111};
parameter logic [7:0] h7 [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b01111111};
parameter logic [7:0] init [7:0]='{
         8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111,
			8'b11111111};
parameter logic [7:0] win[7:0]='{
            8'b11000011,
            8'b10111101,
            8'b01111110,
            8'b01111110,
            8'b01111110,
            8'b01111110,
            8'b10111101,
            8'b11000011};
parameter logic [7:0]  gg[7:0]='{
         8'b01111110,
			8'b10111101,
			8'b11011011,
			8'b11100111,
			8'b11100111,
			8'b11011011,
			8'b10111101,
			8'b01111110};


initial
   begin
		light= 3'b111;
      COMM = 4'b1000;      //initial position at left corner
		position = 0;        //角色移動
		cnt = 0;             //畫面更新
		a = 9;               //a排counter //drop item
		b = 9;               //b排counter //drop item
		c = 9;               //c排counter //drop item
		d = 9;               //d排counter //drop item
		e = 9;               //e排counter //drop item
		f = 9;               //f排counter //drop item
		g = 9;               //g排counter //drop item
		h = 9;		//h排counter //drop item
		flag_ab = 0;
		flag_cd = 0;
		flag_ef = 0;
		flag_gh = 0;
		DATA_R = 8'b11111111;
		DATA_G = 8'b11111111;
		DATA_B = 8'b11111111;
	   a_move [7:0] = init; //a排畫面更新用 //drop item
      b_move [7:0] = init; //b排畫面更新用 //drop item
		c_move [7:0] = init; //c排畫面更新用 //drop item
		d_move [7:0] = init; //d排畫面更新用 //drop item
		e_move [7:0] = init; //e排畫面更新用 //drop item
		f_move [7:0] = init; //f排畫面更新用 //drop item
		g_move [7:0] = init; //g排畫面更新用 //drop item
		h_move [7:0] = init; //h排畫面更新用 //drop item
		a_s_move = init;
		b_s_move = init;
		c_s_move = init;
		d_s_move = init;
		e_s_move = init;
		f_s_move = init;
		g_s_move = init;
		h_s_move = init;
		a_reset = 0;
		b_reset = 0;
		c_reset = 0;
		d_reset = 0;
		e_reset = 0;
		f_reset = 0;
		g_reset = 0;
		h_reset = 0;
		shine = 2'b00;
		life = 12'b000010010100;//
		gameover = 0;
		rnd = 20;
		count_rand = 44;
		s_index = 8;
		seg_cnt = 4'b1110;
		seg_count = 0;
		C1_count = 4'b0000;
		C2_count = 4'b0000;
		C3_count = 4'b0000;
		C4_count = 4'b0000;
		count_ab = 2'b00;
		count_cd = 2'b00;
		count_ef = 2'b00;
		count_gh = 2'b00;
		
   end
divfreq F0(CLK,CLK_div);         //clock of output
divfreq_x F1(CLK,CLK_x);         //clock of charactor
divfreq_1 F2(CLK,CLK_1);         //clock of drop item
divfreq_rand F3(CLK,CLK_rand);   //clock of random
divfreq_2 F6(CLK,CLK_2);
//divfreq_new(CLK,CLK_new);         //clock of counter
music(CLK,reset,beep);
always@(posedge CLK_2)       //counter
begin
   if(~reset)
	begin   
   if(C4_count == 9)
	   begin
		   if(C3_count == 9)
			   begin
				   if(C2_count == 1)
					   ;
					else
					   begin
						   C2_count <= C2_count + 1;
							C3_count <= 0;
							C4_count <= 0;
						end
				end
			else
		      begin
			      C3_count <= C3_count + 1;
					C4_count <= 0;
			   end
		end
	else
	   C4_count <= C4_count + 1;
	end
	else
	   begin
		   C1_count <= 4'b0000;
			C2_count <= 4'b0000;
			C3_count <= 4'b0000;
			C4_count <= 4'b0000;
      end
end
always@(posedge CLK_rand)     // generate random number rnd
begin 
   rnd <= rnd + count_rand;
	count_rand = count_rand + 1;
end
always@(posedge CLK_1)       //掉落物事件  //  新增部分
begin
   //
   if(rnd % 13 == 5 && flag_cd == 0)
	   d <= 0;
	if(rnd % 23 == 6 && flag_cd == 0)
	   c <= 0;
	if(rnd % 11 == 2 && flag_ef == 0)
	   f <= 0;
	if(rnd % 19 == 7 && flag_gh == 0)
	   g <= 0;
	if(rnd % 9 == 2 && flag_ab == 0)
	   a <= 0;
	if(rnd % 31 == 13 && flag_ab == 0)
	   b <= 0;
	if(rnd % 8 == 4 && flag_gh == 0)
	   h <= 0;
	if(rnd % 8 == 1 && flag_ef == 0)
	   e <= 0;
		
	
		
	if(rnd % 5 == 0 && flag_ab ==0)//新增部分
		begin
			a <= 0;
			b <= 0;
			flag_ab = 1;
		end
	if(rnd % 25000000 == 0 && flag_cd ==0)
		begin
			c <= 0;
			d <= 0;
			flag_cd = 1;
		end
	if(rnd % 17 == 0 && flag_ef ==0)
		begin
			e <= 0;
			f <= 0;
			flag_ef = 1;
		end
	if(rnd % 29 == 0 && flag_gh ==0)
		begin
			g <= 0;
			h <= 0;
			flag_gh = 1;
		end
		
	
////////////////////////////
   //collision and drop
	if(flag_ab == 0)
		begin
			if(a_reset == 1 || reset == 1)  // check if collision
				a <= 8;
			else if(a < 9 )   // drop
				begin
					a <= a + 1;
				end
			if(b_reset == 1 || reset == 1)
				b <= 8;
			else if(b < 9 )
				b <= b + 1;
		end
	/////////////////////////////////////////
	else if(flag_ab == 1)
		begin
			if(a_reset ==1 || reset == 1 || b_reset == 1 || reset ==1)
				begin 
					a<=8;
					b<=8;
					flag_ab <= 0;
					count_ab <= 0;
				end
			else if(a<9 && b<9 && flag_ab == 1 && count_ab == 0)
				begin
					a<= a+1;
					b<= b+1;
				end
			//else
			count_ab <= (count_ab +1)%2;
		end
	/////////////////////////////////////////////////////
	
	if(flag_cd == 0)
		begin
			if(c_reset == 1 || reset == 1)
				begin
					c <= 8;
					
				end
			else if(c < 9 )
				c <= c + 1;
			if(d_reset == 1 || reset == 1)
				begin
					d <= 8;
					
					
				end
			else if(d < 9 )
				d <= d + 1;
		end
	///////////////////////////////////////////////////
	else if(flag_cd ==1)
		begin
			if(c_reset == 1 || reset == 1 || d_reset ==1)
				begin
					c<=8;
					d<=8;
					flag_cd <= 0;
					count_cd <=0;
				end
			else if(c<9 && d<9 && flag_cd == 1 && count_cd == 0)
				begin
					c<= c+1;
					d<= d+1;
				end
			else
				begin
					c<=8;
					d<=8;
					flag_cd <= 0;
					count_cd <=0;
				end
					
		  //else
			count_cd <= (count_cd +1)%2;
		end
	/////////////////////////////////////////////////////
	if(flag_ef == 0)
		begin
			if(e_reset == 1 || reset == 1)
			e <= 8;
		else if(e < 9 )
			e <= e + 1;
		if(f_reset == 1 || reset == 1)
			f <= 8;
		else if(f < 9 )
			f <= f + 1;
		end
	///////////////////////////////////////////////////////
	else if(flag_ef == 1)
		begin
			if(e_reset == 1 || reset == 1 || f_reset ==1)
				begin
					e<=8;
					f<=8;
					flag_ef <= 0;
					count_ef <=0;
				end
			else if(e<9 && f<9 && flag_ef == 1 && count_ef == 0)
				begin
					e<= e+1;
					f<= f+1;
				end
				//else
				count_ef <= (count_ef +1)%2;
		end
/////////////////////////////////////////////////////////////////
	if(flag_gh == 0)
		begin
			if(g_reset == 1 || reset == 1)
				g <= 8;
			else if(g < 9 )
				g <= g + 1;
			if(h_reset == 1 || reset == 1)
				h <= 8;
			else if(h < 9 )
				h <= h + 1;
		end
	
//////////////////////////////////////////////////////////
	else if(flag_gh ==1)
		begin
			if(g_reset == 1 || reset == 1 || h_reset ==1)
				begin
					g<=8;
					h<=8;
					flag_gh <= 0;
					count_gh <=0;
				end
			else if(g<9 && h<9 && flag_gh == 1 && count_gh == 0)
				begin
					g<= g+1;
					h<= h+1;
				end
			//else
			count_gh <= (count_gh +1)%2;
		end
   // a~h drop item count

	if(a == 0)
		a_move <= a0;
	else if(a==1)
		a_move <= a1;
	else if(a==2)
		a_move <= a2;
	else if(a==3)
		a_move <= a3;
	else if(a==4)
		a_move <= a4;
	else if(a==5)
		a_move <= a5;
	else if(a==6)
		a_move <= a6;
	else if(a==7)
		a_move <= a7;
	else
		a_move <= init;

	if(b == 0)
		b_move <= b0;
	else if(b==1)
		b_move <= b1;
	else if(b==2)
		b_move <= b2;
	else if(b==3)
		b_move <= b3;
	else if(b==4)
		b_move <= b4;
	else if(b==5)
		b_move <= b5;
	else if(b==6)
		b_move <= b6;
	else if(b==7)
		b_move <= b7;
	else
		b_move <= init;

	if(c == 0)
		c_move <= c0;
	else if(c==1)
		c_move <= c1;
	else if(c==2)
		c_move <= c2;
	else if(c==3)
		c_move <= c3;
	else if(c==4)
		c_move <= c4;
	else if(c==5)
		c_move <= c5;
	else if(c==6)
		c_move <= c6;
	else if(c==7)
		c_move <= c7;
	else
		c_move <= init;

	if(d == 0)
		d_move <= d0;
	else if(d==1)
		d_move <= d1;
	else if(d==2)
		d_move <= d2;
	else if(d==3)
		d_move <= d3;
	else if(d==4)
		d_move <= d4;
	else if(d==5)
		d_move <= d5;
	else if(d==6)
		d_move <= d6;
	else if(d==7)
		d_move <= d7;
	else
		d_move <= init;

	if(e == 0)
		e_move <= e0;
	else if(e==1)
		e_move <= e1;
	else if(e==2)
		e_move <= e2;
	else if(e==3)
		e_move <= e3;
	else if(e==4)
		e_move <= e4;
	else if(e==5)
		e_move <= e5;
	else if(e==6)
		e_move <= e6;
	else if(e==7)
		e_move <= e7;
	else
		e_move <= init;

	if(f == 0)
		f_move <= f0;
	else if(f==1)
		f_move <= f1;
	else if(f==2)
		f_move <= f2;
	else if(f==3)
		f_move <= f3;
	else if(f==4)
		f_move <= f4;
	else if(f==5)
		f_move <= f5;
	else if(f==6)
		f_move <= f6;
	else if(f==7)
		f_move <= f7;
	else
		f_move <= init;

	if(g == 0)
		g_move <= g0;
	else if(g==1)
		g_move <= g1;
	else if(g==2)
		g_move <= g2;
	else if(g==3)
		g_move <= g3;
	else if(g==4)
		g_move <= g4;
	else if(g==5)
		g_move <= g5;
	else if(g==6)
		g_move <= g6;
	else if(g==7)
		g_move <= g7;
	else
		g_move <= init;

	if(h == 0)
		h_move <= h0;
	else if(h==1)
		h_move <= h1;
	else if(h==2)
		h_move <= h2;
	else if(h==3)
		h_move <= h3;
	else if(h==4)
		h_move <= h4;
	else if(h==5)
		h_move <= h5;
	else if(h==6)
		h_move <= h6;
	else if(h==7)
		h_move <= h7;
	else
		h_move <= init;
end
always@(posedge CLK_x)       //charator move detect
begin
   if(left)                          //move left
	   begin
	   if(position==0)
		   position <= position;
		else
		   position <= position - 1;
		end
	else if(right)                    //move right
	   begin
		if(position==7)
		   position <= position;
		else
		   position <= position + 1;
		end
	else
	   position <= position;
end
always@(posedge CLK_div)	  //不斷畫面更新
begin
   //counter
   if(seg_cnt == 4'b0111)
		seg_cnt <= 4'b1110;
	else
		seg_cnt <= {seg_cnt[2:0],1'b1};
	//	
   if(cnt>=7)
	   cnt <= 0;
	else
      cnt <= cnt + 1;
	COMM <= {1'b1, cnt};
	
	//reset game
	if(reset)
	   begin
		   gameover <= 0;
			DATA_R <= 8'b11111111;
			DATA_B <= 8'b11111111;
			DATA_G <= 8'b11111111;
			life <= 12'b000010010100;
			shine <= 2'b00;
			
			
		end
	if(gameover == 0)
	begin
			//counter
		if(C2_count == 0 && C3_count == 6 && C4_count == 0)
		   gameover <= 1;
		case({seg_cnt})
		4'b1110:seg_count <= 3;
		4'b1101:seg_count <= 0;
		4'b1011:seg_count <= 1;
		4'b0111:seg_count <= 2;
		endcase
	   index[0] <= C4_count;
		index[1] <= C3_count;
		index[2] <= C2_count;
		index[3] <= C1_count;
		A_count <= index[seg_count];
		case(A_count)
		4'b0000: {seg} = 7'b1000000;
		4'b0001: {seg} = 7'b1111001;
		4'b0010: {seg} = 7'b0100100;
		4'b0011: {seg} = 7'b0110000;
		4'b0100: {seg} = 7'b0011001;
		4'b0101: {seg} = 7'b0010010;
		4'b0110: {seg} = 7'b0000010;
		4'b0111: {seg} = 7'b1111000;
		4'b1000: {seg} = 7'b0000000;
		4'b1001: {seg} = 7'b0011000;

		default: {seg} = 7'b1111111;
		endcase
		//end counter
		if(position==0)
			DATA_B <= X0[cnt];
		else if(position==1)
			DATA_B <= X1[cnt];
		else if(position==2)
			DATA_B <= X2[cnt];
		else if(position==3)
			DATA_B <= X3[cnt];
		else if(position==4)
			DATA_B <= X4[cnt];
		else if(position==5)
			DATA_B <= X5[cnt];
		else if(position==6)
			DATA_B <= X6[cnt];
		else if(position==7)
			DATA_B <= X7[cnt];
		else
			DATA_B <= DATA_B;
		DATA_R <= a_move[cnt] & b_move[cnt] & c_move[cnt] & d_move[cnt] & e_move[cnt] & f_move[cnt] & g_move[cnt] & h_move[cnt];
		DATA_G <= a_s_move[cnt] & b_s_move[cnt] & c_s_move[cnt] & d_s_move[cnt] & e_s_move[cnt] & f_s_move[cnt] & g_s_move[cnt] & h_s_move[cnt];
		
		
		//collision
      
	   // collision end
		if((DATA_B[7]==0) && DATA_R[7]==0)
			life <= life - 5;
			if (life >= 200) //扣血
				light <= 3'b111;
			else if (life >= 100)
				light <= 3'b011;
			else light <= 3'b001;
		if(life <= 0)
			begin
				gameover <= 2;         //遊戲結束
				light <= 3'b000;
			end
			
			end
	else if(gameover ==1)
	   begin
	      DATA_B <= win[cnt];
		   DATA_R <= win[cnt];
			DATA_G <= 8'b11111111;
	   end
	else  // gameover == 2
		DATA_R <= gg[cnt];
		
end

endmodule



module divfreq(input CLK, output reg CLK_div); //畫面更新用 1000Hz
reg [24:0] Count;
always @(posedge CLK)
begin
if(Count > 50000)
begin
Count <= 25'b0;
CLK_div <= ~CLK_div;
end
else
Count <= Count + 1'b1;
end
endmodule

module divfreq_x(input CLK, output reg CLK_x); //角色移動檢測用 間隔約0.08秒
reg [24:0] Count;
always @(posedge CLK)
begin
if(Count > 4000000)
begin
Count <= 25'b0;
CLK_x <= ~CLK_x;
end
else
Count <= Count + 1'b1;
end
endmodule

module divfreq_1(input CLK, output reg CLK_1); //掉落物 0.5Hz
reg [24:0] Count;
always @(posedge CLK)
begin
if(Count > 6250000)    // origanl: 12500000   , new : 1250000
begin
Count <= 25'b0;
CLK_1 <= ~CLK_1;
end
else
Count <= Count + 1'b1;
end
endmodule

module divfreq_new(input CLK, output reg CLK_new); //掉落物 0.5Hz
reg [24:0] Count;
always @(posedge CLK)
begin
if(Count > 18750000)    // newest : 1250000
begin
Count <= 25'b0;
CLK_new <= ~CLK_new;
end
else
Count <= Count + 1'b1;
end
endmodule



module divfreq_rand(input CLK, output CLK_rand); //掉落物位置選擇
reg [24:0] Count;
integer s;
always @(posedge CLK)
begin
if(Count > 2500000)
begin
   Count <= 25'b0;
	CLK_rand <= ~CLK_rand;
end
else
   Count <= Count + 1'b1;
end
endmodule



module divfreq_2(input CLK, output reg CLK_2);  //clock of counter
reg [24:0] Count;
always @(posedge CLK)
begin
if(Count > 25000000)
begin
Count <= 25'b0;
CLK_2 <= ~CLK_2;
end
else
Count <= Count + 1'b1;
end
endmodule

module divfreq_3(input CLK, output reg CLK_3);  //speed up
reg [24:0] Count;
always @(posedge CLK)
begin
if(Count > 25000000)
begin
Count <= 25'b0;
CLK_3 <= ~CLK_3;
end
else
Count <= Count + 1'b1;
end
endmodule

module music (
	clk,
	button,
	beep
);

input clk;
input button;
output beep;

reg [23:0] counter_4Hz;
reg [23:0] counter_6MHz;
reg [13:0] count;
reg [13:0] origin;
reg audio_reg;
reg clk_6MHz;
reg clk_4Hz;
reg [4:0] note;
reg [7:0] len;

assign beep = button ?  1'b1 : audio_reg;

always @ (posedge clk) begin
	counter_6MHz <= counter_6MHz + 1'b1;
	if (counter_6MHz == 1) begin
		clk_6MHz = ~clk_6MHz;
		counter_6MHz <= 24'b0;
	end
end

always @ (posedge clk) begin
	counter_4Hz <= counter_4Hz + 1'b1;
	if (counter_4Hz == 2999999) begin	
		clk_4Hz = ~clk_4Hz;
		counter_4Hz <= 24'b0;
	end
end

always @ (posedge clk_6MHz) begin
    if(count == 16383) begin
        count = origin;
        audio_reg = ~audio_reg;
    end else
		count = count + 1;
end


always @ (posedge clk_4Hz) begin
	case (note)
		'd1: origin <= 'd4916;
		'd2: origin <= 'd6168;
		'd3: origin <= 'd7281;
		'd4: origin <= 'd7791;
		'd5: origin <= 'd8730;
		'd6: origin <= 'd9565;
		'd7: origin <= 'd10310;
		'd8: origin <= 'd010647;
		'd9: origin <= 'd011272;
		'd10: origin <= 'd011831;
		'd11: origin <= 'd012087;
		'd12: origin <= 'd012556;
		'd13: origin <= 'd012974;
		'd14: origin <= 'd013346;
		'd15: origin <= 'd13516;
		'd16: origin <= 'd13829;
		'd17: origin <= 'd14108;
		'd18: origin <= 'd11535;
		'd19: origin <= 'd14470;
		'd20: origin <= 'd14678;
		'd21: origin <= 'd14864;
		default: origin <= 'd011111;
    endcase             
end

always @ (posedge clk_4Hz) begin
	if (len == 63)
		len <= 0;
    else
		len <= len + 1;
	case (len)
		0: note <= 3;
		1: note <= 3;
		2: note <= 3;
		3: note <= 3;
		4: note <= 5;
		5: note <= 5;
		6: note <= 5;
		7: note <= 6;
		8: note <= 8;
		9: note <= 8;
		10: note <= 8;
		11: note <= 6;
		12: note <= 6;
		13: note <= 6;
		14: note <= 6;
		15: note <= 12;
		16: note <= 12;
		17: note <= 12;
		18: note <= 15;
		19: note <= 15;
		20: note <= 15;
		21: note <= 15;
		22: note <= 15;
		23: note <= 9;
		24: note <= 9;
		25: note <= 9;
		26: note <= 9;
		27: note <= 9;
		28: note <= 9;
		29: note <= 9;
		30: note <= 9;
		31: note <= 9;
		32: note <= 9;
		33: note <= 9;
		34: note <= 10;
		35: note <= 7;
		36: note <= 7;
		37: note <= 6;
		38: note <= 6;
		39: note <= 5;
		40: note <= 5;
		41: note <= 5;
		42: note <= 6;
		43: note <= 8;
		44: note <= 8;
		45: note <= 9;
		46: note <= 9;
		47: note <= 3;
		48: note <= 3;
		49: note <= 8;
		50: note <= 8;
		51: note <= 8;
		52: note <= 5;
		53: note <= 5;
		54: note <= 8;
		55: note <= 5;
		56: note <= 5;
		57: note <= 5;
		58: note <= 5;
		59: note <= 5;
		60: note <= 5;
		61: note <= 5;
		62: note <= 5;
		63: note <= 5;
	endcase            
end
endmodule

