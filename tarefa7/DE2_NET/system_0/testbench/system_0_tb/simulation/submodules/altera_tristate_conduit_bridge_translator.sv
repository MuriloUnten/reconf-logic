
`timescale 1 ns / 1 ns			    

module altera_tristate_conduit_bridge_translator (
                     inout wire [8-1:0] in_tri_state_bridge_0_data
                     ,inout wire [8-1:0] tri_state_bridge_0_data
                     ,input wire [1-1:0] in_tri_state_bridge_0_readn
                     ,output wire [1-1:0] tri_state_bridge_0_readn
                     ,input wire [1-1:0] in_write_n_to_the_cfi_flash_0
                     ,output wire [1-1:0] write_n_to_the_cfi_flash_0
                     ,input wire [22-1:0] in_tri_state_bridge_0_address
                     ,output wire [22-1:0] tri_state_bridge_0_address
                     ,input wire [1-1:0] in_select_n_to_the_cfi_flash_0
                     ,output wire [1-1:0] select_n_to_the_cfi_flash_0
		);
       altera_inout #(
           .WIDTH_A(8),
           .WIDTH_B(8)
       ) tri_state_bridge_0_data_inout_module (
           .a(tri_state_bridge_0_data),
           .b(in_tri_state_bridge_0_data)
       );
       assign tri_state_bridge_0_readn = in_tri_state_bridge_0_readn;
       assign write_n_to_the_cfi_flash_0 = in_write_n_to_the_cfi_flash_0;
       assign tri_state_bridge_0_address = in_tri_state_bridge_0_address;
       assign select_n_to_the_cfi_flash_0 = in_select_n_to_the_cfi_flash_0;
endmodule

