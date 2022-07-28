module dma_reg (
    input clk;
    input rstn;
);
wire wr_dmactrl            ;
wire wr_debugctrl          ;
wire wr_priorityctrl1      ;
wire wr_prioritystat       ;
wire wr_mode               ;
wire wr_control            ;
wire wr_burst_size         ;
wire wr_burst_count        ;
wire wr_src_burst_step     ;
wire wr_dst_burst_step     ;
wire wr_transfer_size      ;
wire wr_transfer_count     ;
wire wr_src_transfer_step  ;
wire wr_dst_transfer_step  ;
wire wr_src_wap_size       ;
wire wr_src_wap_count      ;
wire wr_src_wap_step       ;
wire wr_dst_wap_size       ;
wire wr_dst_wap_count      ;
wire wr_dst_wap_step       ;
wire wr_src_beg_addr_shadow;
wire wr_src_addr_shadow    ;
wire wr_src_beg_addr_active;
wire wr_src_addr_active    ;
wire wr_dst_beg_addr_shadow;
wire wr_dst_addr_shadow    ;
wire wr_dst_beg_addr_active;
wire wr_dst_addr_active    ;


    assign wr_dmactrl                = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DMACTRL;
    assign wr_debugctrl              = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DEBUGCTRL;
    assign wr_priorityctrl1          = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `PRIORITYCTRL1;
    assign wr_prioritystat           = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `PRIORITYSTAT;
//ch_reg
    assign wr_mode                   = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `MODE;
    assign wr_control                = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `CONTROL;
    assign wr_burst_size             = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `BURST_SIZE;
    assign wr_burst_count            = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `BURST_COUNT;
    assign wr_src_burst_step         = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `SRC_BURST_STEP;
    assign wr_dst_burst_step         = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DST_BURST_STEP;
    assign wr_transfer_size          = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `TRANSFER_SIZE;
    assign wr_transfer_count         = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `TRANSFER_COUNT;
    assign wr_src_transfer_step      = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `SRC_TRANSFER_STEP;
    assign wr_dst_transfer_step      = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DST_TRANSFER_STEP;

    assign wr_src_wap_size           = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `SRC_WRAP_SIZE;
    assign wr_src_wap_count          = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `SRC_WRAP_COUNT;
    assign wr_src_wap_step           = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `SRC_WRAP_STEP;

    assign wr_dst_wap_size           = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DST_WRAP_SIZE;
    assign wr_dst_wap_count          = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DST_WRAP_COUNT;
    assign wr_dst_wap_step           = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DST_WRAP_STEP;

    assign wr_src_beg_addr_shadow    = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `SRC_BEG_ADDR_SHADOW;
    assign wr_src_addr_shadow        = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `SRC_ADDR_SHADOW;
    assign wr_src_beg_addr_active    = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `SRC_BEG_ADDR_ACTIVE;
    assign wr_src_addr_active        = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `SRC_ADDR_ACTIVE;
    
    assign wr_dst_beg_addr_shadow    = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DST_BEG_ADDR_SHADOW;
    assign wr_dst_addr_shadow        = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DST_ADDR_SHADOW;
    assign wr_dst_beg_addr_active    = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DST_BEG_ADDR_ACTIVE;
    assign wr_dst_addr_active        = !edma_running & spr_ce_i & spr_we_i & spr_adr_i == `DST_ADDR_ACTIVE;
//DMACTRL
    reg priorityreset;
    reg hardreset;
  always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        priorityreset <= 1'b0;
        hardreset     <= 1'b0;
    end
    else if(wr_dmactrl)begin
        priorityreset <= spr_dat_i[1];
        hardreset     <= spr_dat_i[0];
    end
  end
    
//DEBUGCTRL
    reg free;
  always @(negedge clk or posedge rstn ) begin
    if(~rstn)
        free <= 1'b0;
    else if(wr_debugctrl)
        free <= spr_dat_i[15];
  end

  //PRIORITYCTRL1 REG
  reg ch1priority;
always @(posedge clk or negedge rstn) begin
    if(~rstn)
        ch1priority <= 1'b0;
    else if(wr_priorityctrl1)
        ch1priority <= spr_dat_i[0];
end

 //PRIORITYSTAT Register ---  read only

//******CH_REG******//
//mode reg
reg chint;      //[15]
reg datasize;   //[14]
reg continuous; //[11]
reg oneshot;    //[10]
reg chintmode;  //[ 9]
reg perinte;    //[ 8]
reg ovrinte;    //[ 7]
reg [4:0]perintsel;  //[4:0]

always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        chinte        <= 1'b0;
        datasize     <= 1'b0;   
        continuous   <= 1'b0;
        oneshot      <= 1'b0;
        chintmode    <= 1'b0;
        perinte      <= 1'b0;
        ovrinte      <= 1'b0;
        perintsel    <= 4'd0;  
    end
    else if(wr_mode)begin
        chinte        <= spr_dat_i[15];
        datasize     <= spr_dat_i[14];   
        continuous   <= spr_dat_i[11];
        oneshot      <= spr_dat_i[10];
        chintmode    <= spr_dat_i[ 9];
        perinte      <= spr_dat_i[ 8];
        ovrinte      <= spr_dat_i[ 7];
        perintsel    <= spr_dat_i[4:0];  
    end
end

//CONTROL Register  

//OVRFLG ---READ ONLY  [14]
//RUNSTS ---READ ONLY  [13]
//BURSTS ---READ ONLY  [12]
//TRANSFERSTS ---READ ONLY [11]
//PERINTFLG ---READ ONLY [8]

reg errclr; //[7]
reg perintclr; //[4]
reg perintfrc; //[3]
reg softreset; //[2]
reg halt;      //[1]
reg run;       //[0]
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        errclr       <= 1'b0;
        perintclr    <= 1'b0;
        perintfrc    <= 1'b0;
        softreset    <= 1'b0;
        halt         <= 1'b0;
        run          <= 1'b0;
    end
    else if(wr_control)begin
        errclr       <= spr_dat_i[7];
        perintclr    <= spr_dat_i[4];
        perintfrc    <= spr_dat_i[3];
        softreset    <= spr_dat_i[2];
        halt         <= spr_dat_i[1];
        run          <= spr_dat_i[0];
    end
end

//BURST_SIZE Register
reg [4:0]burstsize;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        burstsize <= 5'd0;
    end
    else if(wr_burstsize)begin
        burstsize <= spr_dat_i[4:0];
    end
end

//BURST_COUNT Register  ---READ ONLY
//BURSTCOUNT [4:0]




//SRC_BURST_STEP Register
reg [15:0]srcburststep;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        srcburststep <= 16'd0;
    end
    else if(wr_src_burst_step)begin
        srcburststep <= spr_dat_i[15:0];
    end
end


//DST_BURST_STEP Register
reg [15:0]dstburststep;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        dstburststep <= 16'd0;
    end
    else if(wr_dst_burst_step)begin
        dstburststep <= spr_dat_i[15:0];
    end
end


//TRANSFER_SIZE Register
reg [15:0]transfersize;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        transfersize <= 16'd0;
    end
    else if(wr_transfer_size)begin
        transfersize <= spr_dat_i[15:0];
    end
end

//TRANSFER_COUNT Register
reg [15:0]transfercount;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        transfercount <= 16'd0;
    end
    else if(wr_transfer_count)begin
        transfercount <= spr_dat_i[15:0];
    end
end

//SRC_TRANSFER_STEP Register
reg [15:0]srctransferstep;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        srctransferstep <= 16'd0;
    end
    else if(wr_src_transfer_step)begin
        srctransferstep <= spr_dat_i[15:0];
    end
end


//DST_TRANSFER_STEP Register
reg [15:0]dsttransferstep;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        dsttransferstep <= 16'd0;
    end
    else if(wr_dst_transfer_step)begin
        dsttransferstep <= spr_dat_i[15:0];
    end
end


//SRC_WRAP_SIZE Register
reg [15:0]srcwapsize;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        srcwapsize <= 16'd0;
    end
    else if(wr_src_wap_size)begin
        srcwapsize <= spr_dat_i[15:0];
    end
end


//SRC_WRAP_COUNT Register
reg [15:0]src_wapsize;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        src_wapsize <= 16'd0;
    end
    else if(wr_src_wap_count)begin
        src_wapsize <= spr_dat_i[15:0];
    end
end


//SRC_WRAP_STEP Register
reg [15:0]srcwrapstep;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        srcwrapstep <= 16'd0;
    end
    else if(wr_src_wap_step)begin
        srcwrapstep <= spr_dat_i[15:0];
    end
end

//DST_WRAP_SIZE Register
reg [15:0]dstwapsize;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        dstwapsize <= 16'd0;
    end
    else if(wr_dst_wap_size)begin
        dstwapsize <= spr_dat_i[15:0];
    end
end


//DST_WRAP_COUNT Register
reg [15:0]dst_wapsize;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        dst_wapsize <= 16'd0;
    end
    else if(wr_dst_wap_count)begin
        dst_wapsize <= spr_dat_i[15:0];
    end
end


//DST_WRAP_STEP Register
reg [15:0]dstwrapstep;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        dstwrapstep <= 16'd0;
    end
    else if(wr_dst_wap_step)begin
        dstwrapstep <= spr_dat_i[15:0];
    end
end


//SRC_BEG_ADDR_SHADOW Register
reg [31:0]src_begaddr_shadow;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        src_begaddr_shadow <= 32'd0;
    end
    else if(wr_src_beg_addr)begin
        src_begaddr_shadow <= spr_dat_i;
    end
end



//SRC_ADDR_SHADOW Register
reg [31:0]src_addr_shadow;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        src_addr_shadow <= 32'd0;
    end
    else if(wr_src_addr_shadow)begin
        src_addr_shadow <= spr_dat_i;
    end
end

//SRC_BEG_ADDR_ACTIVE Register
reg [31:0]src_begaddr_active;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        src_begaddr_active <= 32'd0;
    end
    else if(wr_src_beg_addr_active)begin
        src_begaddr_active <= spr_dat_i;
    end
end


//SRC_ADDR_ACTIVE Register
reg [31:0]src_addr_active;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        src_addr_active <= 32'd0;
    end
    else if(wr_src_addr_active)begin
        src_addr_active <= spr_dat_i;
    end
end


//DST_BEG_ADDR_SHADOW Register
reg [31:0]dst_begaddr_shadow;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        dst_begaddr_shadow <= 32'd0;
    end
    else if(wr_dst_beg_addr)begin
        dst_begaddr_shadow <= spr_dat_i;
    end
end



//DST_ADDR_SHADOW Register
reg [31:0]dst_addr_shadow;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        dst_addr_shadow <= 32'd0;
    end
    else if(wr_dst_addr_shadow)begin
        dst_addr_shadow <= spr_dat_i;
    end
end

//DST_BEG_ADDR_ACTIVE Register
reg [31:0]dst_begaddr_active;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        dst_begaddr_active <= 32'd0;
    end
    else if(wr_dst_beg_addr_active)begin
        dst_begaddr_active <= spr_dat_i;
    end
end


//DST_ADDR_ACTIVE Register
reg [31:0]dst_addr_active;
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        dst_addr_active <= 32'd0;
    end
    else if(wr_dst_addr_active)begin
        dst_addr_active <= spr_dat_i;
    end
end

//**********read register**********//
reg [15:0]rd_dmactrl              ;
reg [31:0]rd_debugctrl            ;
reg [31:0]rd_priorityctrl1        ;
reg [31:0]rd_prioritystat         ;
reg [31:0]rd_mode                 ;
reg [31:0]rd_control              ;
reg [31:0]rd_burst_size           ;
reg [31:0]rd_burst_count          ;
reg [31:0]rd_src_burst_step       ;
reg [31:0]rd_dst_burst_step       ;
reg [31:0]rd_transfer_size        ;
reg [31:0]rd_transfer_count       ;
reg [31:0]rd_src_transfer_step    ;
reg [31:0]rd_dst_transfer_step    ;
reg [31:0]rd_src_wap_size         ;
reg [31:0]rd_src_wap_count        ;
reg [31:0]rd_src_wap_step         ;
reg [31:0]rd_dst_wap_size         ;
reg [31:0]rd_dst_wap_count        ;
reg [31:0]rd_dst_wap_step         ;
reg [31:0]rd_src_beg_addr_shadow  ;
reg [31:0]rd_src_addr_shadow      ;
reg [31:0]rd_src_beg_addr_active  ;
reg [31:0]rd_src_addr_active      ;
reg [31:0]rd_dst_beg_addr_shadow  ;
reg [31:0]rd_dst_addr_shadow      ;
reg [31:0]rd_dst_beg_addr_active  ;
reg [31:0]rd_dst_addr_active      ;

always @(priorityreset or hardreset or free or ch1priority or activests_shadow or activests
    or chinte or datasize or continuous or oneshot or chintmode or perinte or ovrinte or perintsel
    or ovrflg or runsts or burststs or transfersts or perintflg or errclr or perintclr or perintfrc or softreset or halt or run
    or burstsize
    or burstcount
    or srcburststep
    or dstburststep
    or transfersize
    or transfercount
    or srctransferstep
    or dsttransferstep
    or srcwapsize
    or src_wapsize
    or srcwrapstep
    or dstwapsize
    or dst_wapsize
    or dstwrapstep
    or src_begaddr_shadow
    or src_addr_shadow
    or src_begaddr_active
    or src_addr_active
    or dst_begaddr_shadow
    or dst_addr_shadow
    or dst_begaddr_active
    or dst_addr_active)
    begin
        rd_dmactrl              = {16{1'b0}};
        rd_debugctrl            = {32{1'b0}};
        rd_priorityctrl1        = {32{1'b0}};
        rd_prioritystat         = {32{1'b0}};
        rd_mode                 = {32{1'b0}};
        rd_control              = {32{1'b0}};
        rd_burst_size           = {32{1'b0}};
        rd_burst_count          = {32{1'b0}};
        rd_src_burst_step       = {32{1'b0}};
        rd_dst_burst_step       = {32{1'b0}};
        rd_transfer_size        = {32{1'b0}};
        rd_transfer_count       = {32{1'b0}};
        rd_src_transfer_step    = {32{1'b0}};
        rd_dst_transfer_step    = {32{1'b0}};
        rd_src_wap_size         = {32{1'b0}};
        rd_src_wap_count        = {32{1'b0}};
        rd_src_wap_step         = {32{1'b0}};
        rd_dst_wap_size         = {32{1'b0}};
        rd_dst_wap_count        = {32{1'b0}};
        rd_dst_wap_step         = {32{1'b0}};
        rd_src_beg_addr_shadow  = {32{1'b0}};
        rd_src_addr_shadow      = {32{1'b0}};
        rd_src_beg_addr_active  = {32{1'b0}};
        rd_src_addr_active      = {32{1'b0}};
        rd_dst_beg_addr_shadow  = {32{1'b0}};
        rd_dst_addr_shadow      = {32{1'b0}};
        rd_dst_beg_addr_active  = {32{1'b0}};
        rd_dst_addr_active      = {32{1'b0}};


        rd_dmactrl[1]           = priorityreset ;
        rd_dmactrl[0]           = hardreset ;
        rd_debugctrl[15]            = free ;
        rd_priorityctrl1[0]        = ch1priority;

        rd_prioritystat[6:4]         = activests_shadow;
        rd_prioritystat[2:0]         = activests;

        rd_mode[15]                 = chinte;
        rd_mode[14]                 = datasize;
        rd_mode[11]                 = continuous;
        rd_mode[10]                 = oneshot;
        rd_mode[ 9]                 = chintmode;
        rd_mode[ 8]                 = perinte;
        rd_mode[ 7]                 = ovrinte;
        // rd_mode[6:5]                 = 
        rd_mode[4:0]                 = perintsel;
        // rd_mode                 = 


        rd_control[14]              = ovrflg;
        rd_control[13]              = runsts;
        rd_control[12]              = burststs;
        rd_control[11]              = transfersts;
        rd_control[ 8]              = perintflg;
        rd_control[ 7]              = errclr;
        rd_control[ 4]              = perintclr;
        rd_control[ 3]              = perintfrc;
        rd_control[ 2]              = softreset;
        rd_control[ 1]              = halt;
        rd_control[ 0]              = run;


        rd_burst_size[4:0]           = burstsize;
        rd_burst_count[4:0]          = burstcount;
        rd_src_burst_step       = srcburststep;
        rd_dst_burst_step       = dstburststep;
        rd_transfer_size        = transfersize;
        rd_transfer_count       = transfercount;
        rd_src_transfer_step    = srctransferstep;
        rd_dst_transfer_step    = dsttransferstep;
        rd_src_wap_size         = srcwapsize;
        rd_src_wap_count        = src_wapsize;
        rd_src_wap_step         = srcwrapstep;
        rd_dst_wap_size         = dstwapsize;
        rd_dst_wap_count        = dst_wapsize;
        rd_dst_wap_step         = dstwrapstep;
        rd_src_beg_addr_shadow  = src_begaddr_shadow;
        rd_src_addr_shadow      = src_addr_shadow;
        rd_src_beg_addr_active  = src_begaddr_active;
        rd_src_addr_active      = src_addr_active;
        rd_dst_beg_addr_shadow  = dst_begaddr_shadow;
        rd_dst_addr_shadow      = dst_addr_shadow;
        rd_dst_beg_addr_active  = dst_begaddr_active;
        rd_dst_addr_active      = dst_addr_active;
    end


endmodule