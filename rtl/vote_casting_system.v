// Supporting RTL reference model for the original Proteus / breadboard project.
// Voter IDs: 0..4. Candidate codes: 0=C1, 1=C2, 2=C3.
module vote_casting_system (
    input wire clk,
    input wire reset,
    input wire vote_enable,
    input wire [2:0] voter_id,
    input wire [1:0] candidate_id,
    output reg [7:0] votes_c1,
    output reg [7:0] votes_c2,
    output reg [7:0] votes_c3,
    output wire [1:0] leader,
    output wire tie,
    output wire [4:0] voted_mask
);
    reg [4:0] has_voted;
    assign voted_mask = has_voted;
    wire valid_voter = (voter_id < 3'd5);
    wire valid_candidate = (candidate_id < 2'd3);
    wire already_voted = valid_voter ? has_voted[voter_id] : 1'b1;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            votes_c1 <= 8'd0;
            votes_c2 <= 8'd0;
            votes_c3 <= 8'd0;
            has_voted <= 5'b0;
        end else if (vote_enable && valid_voter && valid_candidate && !already_voted) begin
            has_voted[voter_id] <= 1'b1;
            case (candidate_id)
                2'd0: votes_c1 <= votes_c1 + 8'd1;
                2'd1: votes_c2 <= votes_c2 + 8'd1;
                2'd2: votes_c3 <= votes_c3 + 8'd1;
                default: ;
            endcase
        end
    end

    wire c1_top = (votes_c1 >= votes_c2) && (votes_c1 >= votes_c3);
    wire c2_top = (votes_c2 >= votes_c1) && (votes_c2 >= votes_c3);
    wire c3_top = (votes_c3 >= votes_c1) && (votes_c3 >= votes_c2);
    assign tie = (c1_top && c2_top) || (c1_top && c3_top) || (c2_top && c3_top);
    assign leader = tie ? 2'b11 : (c1_top ? 2'd0 : (c2_top ? 2'd1 : 2'd2));
endmodule
