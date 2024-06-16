library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY MaxDiff_tb IS 
END MaxDiff_tb;

ARCHITECTURE MaxDiff_Arch OF MaxDiff_tb IS
    -- Declare signals for testbench
    SIGNAL RST : STD_LOGIC := '0';  -- Reset signal
    SIGNAL CLK : STD_LOGIC := '0';  -- Clock signal
    SIGNAL Start_i : STD_LOGIC := '0';  -- Start input signal
    SIGNAL Done_o : STD_LOGIC;  -- Done output signal

BEGIN
    -- Instantiate the unit under test (UUT)
    UUT: entity work.MaxDiff
    PORT MAP (
        RST => RST,
        CLK => CLK,
        Start_i => Start_i,
        Done_o => Done_o
    );

    -- Clock process
    CLK_process: PROCESS
    BEGIN
        CLK <= '0';
        LOOP
            CLK <= NOT CLK;  -- Toggle the clock
            WAIT FOR 5 ns;   -- Clock period of 10 ns (5 ns high, 5 ns low)
        END LOOP;
    END PROCESS CLK_process;

    -- Stimulus process
    Stimulus: PROCESS
    BEGIN
        RST <= '1';  -- Assert reset
        WAIT FOR 10 ns;
        RST <= '0';  -- Deassert reset
        WAIT FOR 10 ns;
        
        -- Test
        Start_i <= '1';  -- Activate start input
        WAIT UNTIL Done_o = '1';  -- Wait until Done_o is '1'
        Start_i <= '0';  -- Deactivate start input

        -- End of simulation
        WAIT;
    END PROCESS Stimulus;

END MaxDiff_Arch;
