package pmp_pkg;
    typedef enum logic[1:0] {
        USER_MODE    = 2'b00,
        RESERVED     = 2'b01,
        SUPER_MODE   = 2'b10,
        MACHINE_MODE = 2'b11
    } pmp_mode_t;

    typedef enum logic[1:0] { 
        OFF   = 2'b00,
        TOR   = 2'b01,
        NA4   = 2'b10,
        NAPOT = 2'b11
    } A_mode_t;

    typedef enum logic [2:0] {
        F3_CSRRW  = 3'b001,
        F3_CSRRS  = 3'b010,
        F3_CSRRC  = 3'b011,
        F3_CSRRWI = 3'b101,
        F3_CSRRSI = 3'b110,
        F3_CSRRCI = 3'b111,
        F3_PRIV   = 3'b000
    } funct3_system_t;

    typedef struct packed {
        logic        lock  ; 
        logic [1:0]  rsv   ;    //Reserve
        logic [1:0]  a     ;
        logic        x     ;
        logic        w     ;
        logic        r     ;
    } pmp_cfg_t;
    
endpackage