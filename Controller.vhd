LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY Controller IS
PORT (
	RST, CLK : IN STD_LOGIC;
	Start_i : IN STD_LOGIC;

    i_lt, max_lt, min_mt: IN STD_LOGIC;

    ld_i, ld_max, ld_min: OUT STD_LOGIC;
    sel_i, sel_max, sel_min: OUT STD_LOGIC;

 	mi_r_en, mi_w_en : OUT STD_LOGIC;
	mo_r_en, mo_w_en : OUT STD_LOGIC;
	size_r_en, size_w_en: OUT STD_LOGIC;

	Done_o : OUT STD_LOGIC  -- Da sua
);
END Controller;

ARCHITECTURE RTL OF Controller IS
TYPE State_type IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S20);
SIGNAL state : State_type;
BEGIN
FSM: PROCESS (RST, CLK)
BEGIN
    IF (RST = '1') THEN
        state <= S0;
    ELSIF (CLK'EVENT and CLK = '1') THEN
        CASE state IS
            WHEN S0 => state <= S1;
            WHEN S1 => 
                IF Start_i = '1' THEN
                    state <= S2;
                ELSE
                    state <= S1;
                END IF;
            WHEN S2 => state <= S20;
            WHEN S20 => state <= S3;
            WHEN S3 => 
                IF i_lt = '1' THEN
                    state <= S4;
                ELSE 
                    state <= S10;
                END IF;
            WHEN S4 => state <= S5;
            WHEN S5 =>
                IF max_lt = '1' THEN
                    state <= S6;
                ELSE 
                    state <= S7;
		        END IF;
            WHEN S6 => state <= S9; -- Da sua
            WHEN S7 =>
                IF min_mt = '1' THEN
                    state <= S8;
                ELSE 
                    state <= S9;
                END IF;
            WHEN S8 => state <= S9;
            WHEN S9 => state <= S3;
            WHEN S10 => state <= S11;
            WHEN S11 => 
                IF Start_i = '0' THEN
                    state <= S11;  -- Da sua
                ELSE
                    state <= S12;	-- Da sua
                END IF;
            WHEN S12 => state <=S0;
            WHEN OTHERS => state <= S0;
        END CASE;
    END IF;
END PROCESS;

-- Combinational Logic
ld_i <= '1' WHEN (state = S2 OR state = S9) ELSE '0';
mi_r_en <= '1' WHEN state = S2 OR state = S4 ELSE '0';
mi_w_en <= '0';
sel_max <= '1' WHEN state = S20 OR state = S6 ELSE '0';
ld_max <= '1' WHEN state = S20 OR state = S6 ELSE '0';
sel_min <= '1' WHEN state = S20 OR state = S8 ELSE '0';
ld_min <= '1' WHEN state = S20 OR state = S8 ELSE '0';
sel_i <= '1' WHEN state = S9 ELSE '0';
size_r_en <= '1' WHEN state = S2 ELSE '0';
size_w_en <= '0';
mo_w_en <= '1' WHEN state = S10  ELSE '0';
mo_r_en <= '0';
Done_o <= '1' WHEN state = S10 ELSE '0';   -- Da sua
END RTL;