Authors: 111321012  111321014
Input/Output unit:

七段顯示器，用來顯示存活時間。
![P_20240103_181945](https://github.com/EmeraldMerchant/fpga_final/assets/96396730/44290ec4-f6f3-4d70-9b52-d574e6b37eae)

LED 陣列，用來計分。
![P_20240103_182014](https://github.com/EmeraldMerchant/fpga_final/assets/96396730/6f3f0c06-1c35-45f4-a339-c6affeec58f0)

8x8 LED 矩陣，用來顯示對戰畫面。下圖為成功的畫面。
![P_20240103_175959](https://github.com/EmeraldMerchant/fpga_final/assets/96396730/c1e7e38e-a280-4cbf-a3eb-ba7e9c91b400)

功能說明:
藍色玩家閃躲天空隨機掉落的綠色球 存活達60秒獲勝 共有約3條命 還額外附加美妙(?)的音樂

程式模組說明:
module Tetris(output reg [7:0] DATA_R, DATA_G, DATA_B, //8x8 LED陣列的顯示控制訊號
            output reg [3:0] COMM,                     //藍色的角色的位置
				output reg [6:0] seg,                          //7段顯示器顯示1/2/3/4/5/6/7/8/9/0
				output reg [3:0] seg_cnt,                      //控制計時器亮哪一個 以達到4個一起顯示
				output[2:0]light,                              //控制剩餘生命顯示 (上排led陣列) 111->011->001->000(gameover)
				output beep,                                   //美妙的音樂！！
            input left,right,reset,shoot,              //角色左右(按鈕1/2),重設(按鈕4),(shoot後來沒用到)
            input CLK);                                //PIN 22 clock

Demo video: 
[Demo Video](https://www.youtube.com/shorts/8HWPAIVlA8Q)https://www.youtube.com/shorts/8HWPAIVlA8Q
