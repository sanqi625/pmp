

module pmp #(
    parameter integer unsigned PMP_PMP_CHANNEL_NUM  = 32    ,
    parameter integer unsigned REQ_PMP_CHANNEL_NUM  = 3     ,
    parameter integer unsigned ADDR_WIDTH       = 32
) (    
    input                               clk                                 ,
    input                               rst_n                               ,

    input                               csr_req_vld                         ,
    input [31:0]                        csr_req_wdata                        ,
    input                               csr_req_addr                        ,
    //...


    input  logic [ADDR_WIDTH-1:0]       v_req_addr   [REQ_PMP_CHANNEL_NUM-1:0]  ,
    input  logic [1:0]                  v_req_mode   [REQ_PMP_CHANNEL_NUM-1:0]  ,
    output logic [REQ_PMP_CHANNEL_NUM-1:0]  v_pass                              
);


    //=========================================================================================
    // PMP config
    //=========================================================================================

    pmp_cfg_t                 v_pmp_cfg         [PMP_CHANNEL_NUM-1:0];    
    logic [ADDR_WIDTH-1:0]    v_pmp_addr        [PMP_CHANNEL_NUM-1:0];   
    logic [ADDR_WIDTH-1:0]    v_pmp_napot_mask  [PMP_CHANNEL_NUM-1:0];
    logic [79:0]              v_pmp_wren                         ;

    always_comb begin
       //v_pmp_wren generation 
    end


    generate for(genvar i=0;i<PMP_PMP_CHANNEL_NUM;i=i+1) begin

        always_ff @(posedge clk or negedge rst_n) begin
            if(~rst_n) begin
                v_pmp_addr[i]       <= 'b0;
                v_pmp_napot_mask[i] <= 'b0;
            end
            else if((~v_pmp_cfg[i].lock) & v_pmp_wren[i]) begin
                v_pmp_addr[i]       <= csr_req_wdata;
                v_pmp_napot_mask[i] <= 'b0;// TODO.
        end 

    end endgenerate


    generate for(genvar j=0; j<(PMP_PMP_CHANNEL_NUM/4);j=j+1) begin

        always_ff @(posedge clk or negedge rst_n) begin
            if      (~rst_n)                                    v_pmp_cfg[j*4] <= 'b0;
            else if ((~v_pmp_cfg[j*4].lock) & v_pmp_wren[j])    v_pmp_cfg[j*4] <= csr_req_wdata[7:0];
        end 

        always_ff @(posedge clk or negedge rst_n) begin
            if      (~rst_n)                                    v_pmp_cfg[j*4+1] <= 'b0;
            else if ((~v_pmp_cfg[j*4+1].lock) & v_pmp_wren[j])  v_pmp_cfg[j*4+1] <= csr_req_wdata[15:8];
        end 

        always_ff @(posedge clk or negedge rst_n) begin
            if      (~rst_n)                                    v_pmp_cfg[j*4+2] <= 'b0;
            else if ((~v_pmp_cfg[j*4+2].lock) & ~(v_pmp_cfg[j*4+2].lock && (v_pmp_cfg[j*4+2].A == TOR))& v_pmp_wren[j])  v_pmp_cfg[j*4+2] <= csr_req_wdata[23:16];
        end 

        always_ff @(posedge clk or negedge rst_n) begin
            if      (~rst_n)                                    v_pmp_cfg[j*4+3] <= 'b0;
            else if ((~v_pmp_cfg[j*4+3].lock) & v_pmp_wren[j])  v_pmp_cfg[j*4+3] <= csr_req_wdata[31:24];
        end 

    end endgenerate


    // read data
    always....

    //=========================================================================================
    // PMP compare array
    //=========================================================================================


    generate for(genvar i=0; i<REQ_PMP_CHANNEL_NUM; i=i+1) begin:pmp_compare_array
        
        pmp_compare #(
            .PMP_CHANNEL_NUM  (REQ_PMP_CHANNEL_NUM  ),
            .ADDR_WIDTH   (ADDR_WIDTHs      )) 
        u_pmp_checker (
            .req_addr           (v_req_addr[i]      ),
            .v_pmp_cfg          (v_pmp_cfg          ),
            .v_pmp_addr         (v_pmp_addr         ),
            .v_pmp_napot_mask   (v_pmp_napot_mask   ),
            .pass               (v_pass[i]          ));

    end endgenerate


endmodule