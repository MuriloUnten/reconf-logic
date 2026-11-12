
`timescale 1 ns / 1 ns

		    
module altera_conduit_pin_divider (
                     output wire [22-1:0] cfi_flash_0_tcm_address_out
                     ,output wire [1-1:0] cfi_flash_0_tcm_read_n_out
                     ,output wire [1-1:0] cfi_flash_0_tcm_write_n_out
                     ,inout wire [8-1:0] cfi_flash_0_tcm_data_out
                     ,output wire [1-1:0] cfi_flash_0_tcm_chipselect_n_out
                     ,input wire [22-1:0] in_tri_state_bridge_0_address
                     ,input wire [1-1:0] in_tri_state_bridge_0_readn
                     ,input wire [1-1:0] in_write_n_to_the_cfi_flash_0
                     ,inout wire [8-1:0] in_tri_state_bridge_0_data
                     ,input wire [1-1:0] in_select_n_to_the_cfi_flash_0
       );
       assign cfi_flash_0_tcm_address_out = in_tri_state_bridge_0_address;
       assign cfi_flash_0_tcm_read_n_out = in_tri_state_bridge_0_readn;
       assign cfi_flash_0_tcm_write_n_out = in_write_n_to_the_cfi_flash_0;
       altera_inout #(
           .WIDTH_A(8),
           .WIDTH_B(8)
       ) cfi_flash_0_tcm_data_out_inout_module (
           .a(cfi_flash_0_tcm_data_out),
           .b(in_tri_state_bridge_0_data)
       );
       assign cfi_flash_0_tcm_chipselect_n_out = in_select_n_to_the_cfi_flash_0;


endmodule

