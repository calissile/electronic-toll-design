module toll (AXLES, VEHICLE, TOLL_PAID, CLOCK, CLK, RESET, TOLL, GO,
                  STOP, BCD_DOLLARS, BCD_CENTS_MSB, BCD_CENTS_LSB);
output reg [0:15]  TOLL;
output reg GO, STOP;
output reg [0:3] BCD_DOLLARS;
output reg [0:3] BCD_CENTS_MSB;
output reg [0:3] BCD_CENTS_LSB;

input CLK, RESET, TOLL_PAID; 
input [0:2] AXLES, VEHICLE;
input [0:12] CLOCK;


always@(*)
begin
if(~RESET) begin
	TOLL <= 16'b0;
	BCD_DOLLARS <= 4'b0;
	BCD_CENTS_MSB <= 4'b0;
	BCD_CENTS_LSB <= 4'b0;
	GO <= 0;
	STOP <= 1;
end

else if(VEHICLE) begin
	if(~TOLL_PAID) begin
		if(CLK) begin	
			STOP <= 1;
			GO <= 0;
			case(AXLES)
			2: begin
				if(CLOCK  >=  420 && CLOCK < 600 )begin
					TOLL <= 16'b1011010;
					BCD_DOLLARS <= 4'b0;
					BCD_CENTS_MSB <= 4'b1001;
					BCD_CENTS_LSB <= 4'b0;
				end
				else if (CLOCK >= 600 && CLOCK < 900 )begin
					TOLL <= 16'b101101;
					BCD_DOLLARS <= 4'b0;
					BCD_CENTS_MSB <= 4'b100;
					BCD_CENTS_LSB <= 4'b101;
				end
				else if (CLOCK >= 900 && CLOCK < 1200)begin
					TOLL <= 16'b1100100;
					BCD_DOLLARS <= 4'b1;
					BCD_CENTS_MSB <= 4'b0;
					BCD_CENTS_LSB <= 4'b0;
				end
				else begin
					TOLL <= 16'b11110;
					BCD_DOLLARS <= 4'b0;
					BCD_CENTS_MSB <= 4'b011;
					BCD_CENTS_LSB <= 4'b0;
				end
			end
			3: begin
				if(CLOCK  >=  420 && CLOCK < 600 ) begin
					TOLL <= 16'b10010001;
					BCD_DOLLARS <= 4'b1;
					BCD_CENTS_MSB <= 4'b100;
					BCD_CENTS_LSB <= 4'b101;
				end
				else if (CLOCK >= 600 && CLOCK < 900 )begin
					TOLL <= 16'b1001011;
					BCD_DOLLARS <= 4'b0;
					BCD_CENTS_MSB <= 4'b111;
					BCD_CENTS_LSB <= 4'b101;
				end
				else if (CLOCK >= 900 && CLOCK < 1200 )begin
					TOLL <= 16'b10100000;
					BCD_DOLLARS <= 4'b1;
					BCD_CENTS_MSB <= 4'b110;
					BCD_CENTS_LSB <= 4'b0;
				end
				else begin
					TOLL <= 16'b111100;
					BCD_DOLLARS <= 4'b0;
					BCD_CENTS_MSB <= 4'b110;
					BCD_CENTS_LSB <= 4'b0;
				end
			end
			4: begin
				if(CLOCK  >=  420 && CLOCK < 600 )begin
					TOLL <= 16'b11000011;
					BCD_DOLLARS <= 4'b1;
					BCD_CENTS_MSB <= 4'b1001;
					BCD_CENTS_LSB <= 4'b101;
				end
				else if (CLOCK >= 600 && CLOCK < 900)begin
					TOLL <= 16'b1100100;
					BCD_DOLLARS <= 4'b1;
					BCD_CENTS_MSB <= 4'b0;
					BCD_CENTS_LSB <= 4'b0;
				end
				else if (CLOCK >= 900 && CLOCK < 1200)begin
					TOLL <= 16'b11111010;
					BCD_DOLLARS <= 4'b010;
					BCD_CENTS_MSB <= 4'b101;
					BCD_CENTS_LSB <= 4'b0;
				end
				else begin
					TOLL <= 16'b1010000;
					BCD_DOLLARS <= 4'b0;
					BCD_CENTS_MSB <= 4'b1000;
					BCD_CENTS_LSB <= 4'b0;
				end
				end
			default: TOLL <= 16'b0;
			endcase		
		
			
			end			
		end
		else begin			
			GO <= 1;	
			STOP <= 0;	
	end
end



end
endmodule

module testbench (AXLES, VEHICLE, TOLL_PAID, CLOCK, CLK, RESET, TOLL, GO,
                  STOP, BCD_DOLLARS, BCD_CENTS_MSB, BCD_CENTS_LSB);

input [0:15]  TOLL;
input GO, STOP;
input [0:3] BCD_DOLLARS;
input [0:3] BCD_CENTS_MSB;
input [0:3] BCD_CENTS_LSB;

output reg CLK, RESET, TOLL_PAID;
output reg [0:12] CLOCK;
output reg [0:2] AXLES, VEHICLE;


initial
  begin
    $dumpvars;
    $dumpfile ("toll.dump");
    AXLES = 0;
    VEHICLE = 0;
    TOLL_PAID = 0;
    CLOCK = 2;
    CLK = 0;
    RESET = 0; // Reset the machine

#10 RESET = 1;
    AXLES = 2;
    VEHICLE = 1;
    TOLL_PAID = 0;
#10 TOLL_PAID = 1;
#10 AXLES = 3;
    VEHICLE = 1;
    TOLL_PAID = 0;
#10 TOLL_PAID = 1;
#10 AXLES = 4;
    VEHICLE = 1;
    TOLL_PAID = 0;
#10 TOLL_PAID = 1;

#10 AXLES = 2;
    VEHICLE = 1;
    TOLL_PAID = 0;
    CLOCK = 480;
#10 TOLL_PAID = 1;
#10 AXLES = 3;
    VEHICLE = 1;
    TOLL_PAID = 0;
#10 TOLL_PAID = 1;
#10 AXLES = 4;
    VEHICLE = 1;
    TOLL_PAID = 0;
#10 TOLL_PAID = 1;

#10 AXLES = 2;
    VEHICLE = 1;
    TOLL_PAID = 0;
    CLOCK = 660;
#10 TOLL_PAID = 1;
#10 AXLES = 3;
    VEHICLE = 1;
    TOLL_PAID = 0;
#10 TOLL_PAID = 1;
#10 AXLES = 4;
    VEHICLE = 1;
    TOLL_PAID = 0;
#10 TOLL_PAID = 1;

#10 AXLES = 2;
    VEHICLE = 1;
    TOLL_PAID = 0;
    CLOCK = 960;
#10 TOLL_PAID = 1;
#10 AXLES = 3;
    VEHICLE = 1;
    TOLL_PAID = 0;
#10 TOLL_PAID = 1;
#10 AXLES = 4;
    VEHICLE = 1;
    TOLL_PAID = 0;
#10 TOLL_PAID = 1;
#10 TOLL_PAID = 0;
#10 $finish;
end

always #10 CLK = ~CLK;

endmodule

module testthis;
wire [0:15]  TOLL;
wire GO, STOP;
wire [0:3] BCD_DOLLARS;
wire [0:3] BCD_CENTS_MSB;
wire [0:3] BCD_CENTS_LSB;
wire CLK, RESET, TOLL_PAID;
wire [0:2] AXLES, VEHICLE;
wire [0:12] CLOCK;

toll(AXLES, VEHICLE, TOLL_PAID, CLOCK, CLK, RESET, TOLL, GO,
                  STOP, BCD_DOLLARS, BCD_CENTS_MSB, BCD_CENTS_LSB);
testbench (AXLES, VEHICLE, TOLL_PAID, CLOCK, CLK, RESET, TOLL, GO,
                  STOP, BCD_DOLLARS, BCD_CENTS_MSB, BCD_CENTS_LSB);

endmodule

