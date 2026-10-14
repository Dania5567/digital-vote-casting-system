`timescale 1ns/1ps
module tb_vote_casting_system;
  reg clk=0, reset=0, vote_enable=0;
  reg [2:0] voter_id=0;
  reg [1:0] candidate_id=0;
  wire [7:0] c1,c2,c3;
  wire [1:0] leader;
  wire tie;
  wire [4:0] voted;
  vote_casting_system dut(clk,reset,vote_enable,voter_id,candidate_id,c1,c2,c3,leader,tie,voted);
  always #5 clk=~clk;
  task submit;
    input [2:0] voter;
    input [1:0] candidate;
    begin
      @(negedge clk); voter_id=voter; candidate_id=candidate; vote_enable=1;
      @(negedge clk); vote_enable=0;
    end
  endtask
  task expect_counts;
    input [7:0] a,b,c;
    begin
      #1;
      if(c1!==a || c2!==b || c3!==c) begin
        $display("FAIL count: expected %0d/%0d/%0d got %0d/%0d/%0d",a,b,c,c1,c2,c3);
        $finish(1);
      end
    end
  endtask
  initial begin
    reset=1; #2; reset=0; expect_counts(0,0,0);
    submit(0,0); expect_counts(1,0,0);
    submit(1,1); expect_counts(1,1,0);
    submit(2,0); expect_counts(2,1,0);
    submit(0,2); expect_counts(2,1,0); // duplicate ID
    submit(7,2); expect_counts(2,1,0); // invalid voter
    submit(3,3); expect_counts(2,1,0); // invalid candidate
    submit(3,2); expect_counts(2,1,1);
    submit(4,1); expect_counts(2,2,1);
    if(tie!==1'b1 || leader!==2'b11 || voted!==5'b11111) begin
      $display("FAIL tie/leader/voted states"); $finish(1);
    end
    $display("PASS: reset, 5 valid votes, duplicate and invalid suppression, tie logic");
    $finish;
  end
endmodule
