library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DE2_Top is
    port (
        CLOCK_50 : in std_logic;
        KEY : in std_logic_vector(0 downto 0);
        DRAM_CLK : out std_logic;
        DRAM_CKE : out std_logic;
        DRAM_ADDR : out std_logic_vector(11 downto 0);
        DRAM_BA_0 : out std_logic;
        DRAM_BA_1 : out std_logic;
        DRAM_CS_N : out std_logic;
        DRAM_CAS_N : out std_logic;
        DRAM_RAS_N : out std_logic;
        DRAM_WE_N : out std_logic;
        DRAM_DQ : inout std_logic_vector(15 downto 0);
        DRAM_UDQM : out std_logic;
        DRAM_LDQM : out std_logic;
        ENET_DATA : inout std_logic_vector(15 downto 0);
        ENET_CMD : out std_logic;
        ENET_RD_N : out std_logic;
        ENET_WR_N : out std_logic;
        ENET_CS_N : out std_logic;
        ENET_RST_N : out std_logic;
        ENET_INT : in std_logic;
        ENET_CLK : out std_logic
    );
end entity DE2_Top;

architecture rtl of DE2_Top is

    signal sys_clk : std_logic;

    component nios_system is
        port (
            clk_clk : in std_logic := 'X';
            reset_reset_n : in std_logic := 'X';
            sdram_wire_addr : out std_logic_vector(11 downto 0);
            sdram_wire_ba : out std_logic_vector(1 downto 0);
            sdram_wire_cas_n : out std_logic;
            sdram_wire_cke : out std_logic;
            sdram_wire_cs_n : out std_logic;
            sdram_wire_dq : inout std_logic_vector(15 downto 0) := (others => 'X');
            sdram_wire_dqm : out std_logic_vector(1 downto 0);
            sdram_wire_ras_n : out std_logic;
            sdram_wire_we_n : out std_logic;
            dm9000a_conduit_iOSC_50 : in std_logic := 'X';
            dm9000a_conduit_ENET_DATA : inout std_logic_vector(15 downto 0) := (others => 'X');
            dm9000a_conduit_ENET_CMD : out std_logic;
            dm9000a_conduit_ENET_RD_N : out std_logic;
            dm9000a_conduit_ENET_WR_N : out std_logic;
            dm9000a_conduit_ENET_CS_N : out std_logic;
            dm9000a_conduit_ENET_RST_N : out std_logic;
            dm9000a_conduit_ENET_CLK : out std_logic;
            dm9000a_conduit_ENET_INT : in std_logic := 'X'
        );
    end component nios_system;

    component sdram_pll is
        port (
            inclk0 : in std_logic;
            c0     : out std_logic;
            c1     : out std_logic
        );
    end component;

begin

    u1_pll : component sdram_pll
        port map (
            inclk0 => CLOCK_50,
            c0     => sys_clk,
            c1     => DRAM_CLK
        );

    u0 : component nios_system
        port map (
            clk_clk => sys_clk,
            reset_reset_n => KEY(0),
            sdram_wire_addr => DRAM_ADDR,
            sdram_wire_ba(0) => DRAM_BA_0,
            sdram_wire_ba(1) => DRAM_BA_1,
            sdram_wire_cas_n => DRAM_CAS_N,
            sdram_wire_cke => DRAM_CKE,
            sdram_wire_cs_n => DRAM_CS_N,
            sdram_wire_dq => DRAM_DQ,
            sdram_wire_dqm(0) => DRAM_LDQM,
            sdram_wire_dqm(1) => DRAM_UDQM,
            sdram_wire_ras_n => DRAM_RAS_N,
            sdram_wire_we_n => DRAM_WE_N,
            dm9000a_conduit_iOSC_50 => CLOCK_50,
            dm9000a_conduit_ENET_DATA => ENET_DATA,
            dm9000a_conduit_ENET_CMD => ENET_CMD,
            dm9000a_conduit_ENET_RD_N => ENET_RD_N,
            dm9000a_conduit_ENET_WR_N => ENET_WR_N,
            dm9000a_conduit_ENET_CS_N => ENET_CS_N,
            dm9000a_conduit_ENET_RST_N => ENET_RST_N,
            dm9000a_conduit_ENET_CLK => ENET_CLK,
            dm9000a_conduit_ENET_INT => ENET_INT
        );

end architecture rtl;