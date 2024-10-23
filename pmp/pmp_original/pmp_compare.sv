
module pmp_compare #(
    parameter integer unsigned PMP_CHANNEL_NUM  = 32,
    parameter integer unsigned ADDR_WIDTH   = 32
) (
    input  logic [ADDR_WIDTH-1:0]    req_addr                               ,
    input  pmp_cfg_t                 v_pmp_cfg         [PMP_CHANNEL_NUM-1:0]    ,
    input  logic [ADDR_WIDTH-1:0]    v_pmp_addr        [PMP_CHANNEL_NUM-1:0]    ,
    input  logic [ADDR_WIDTH-1:0]    v_pmp_napot_mask  [PMP_CHANNEL_NUM-1:0]    ,
    output logic                     pass
);


    logic [PMP_CHANNEL_NUM-1:0] v_hit;


    generate for(genvar i=0;i<PMP_CHANNEL_NUM;i=i+1) begin: check_unit

        logic [ADDR_WIDTH-1:0] pmp_addr_last;
        
        if(i==0)    pmp_addr_last = {ADDR_WIDTH{1'b0}};
        else        pmp_addr_last = v_pmp_addr[i-1];

        pmp_addr_check #(
            .ADDR_WIDTH(ADDR_WIDTH))
        u_check_unit (
            .req_addr       (req_addr               ),
            .pmp_cfg        (v_pmp_cfg[i]           ),
            .pmp_addr       (v_pmp_addr[i]          ),
            .pmp_addr_last  (pmp_addr_last          ),
            .pmp_napot_mask (v_pmp_napot_mask[i]    ),
            .hit            (v_hit[i]               ));

    end endgenerate

    // leading one and mux.
    assign pass = ~ (|v_hit);

endmodule