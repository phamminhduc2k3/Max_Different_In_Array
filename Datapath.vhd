LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.MyLib.all;

ENTITY Datapath IS
PORT (
    RST, CLK : IN STD_LOGIC;
    ld_i, ld_max, ld_min : IN STD_LOGIC; -- flag enable
    i_lt, max_lt, min_mt : OUT STD_LOGIC;
    sel_i, sel_max, sel_min : IN STD_LOGIC;
    mi_r_en, mi_w_en : IN STD_LOGIC;
    mo_r_en, mo_w_en : IN STD_LOGIC;
    size_r_en, size_w_en: IN STD_LOGIC;
	 max_val, min_val : OUT INTEGER
);
END Datapath;

ARCHITECTURE RTL OF Datapath IS 
SIGNAL max_out, min_out : Integer;  
SIGNAL max_src, min_src : Integer; 
SIGNAL i_src : Integer; 
SIGNAL I : Integer := 1;
SIGNAL in_data, sub, out_data : INTEGER;
SIGNAL MemIn_out : INTEGER := 0; -- output of memIn (Dout)
SIGNAL Size_out, Size_in : INTEGER;
SIGNAL done: STD_LOGIC := '0';
BEGIN 
    -- Mux for i
    i_src <= 0 WHEN sel_i = '0' ELSE (I+1);

    -- Mux for Max
    max_src <= MemIn_out WHEN sel_max = '1' ELSE max_out;
    -- Mux for Min
    min_src <= MemIn_out WHEN sel_min = '1' ELSE min_out;

    -- compare i less than array's size or not
    i_lt <= '1' WHEN I < Size_out ELSE '0';
    done <= '1' WHEN I = Size_out ELSE '0';
    -- compare max less than curr or not
    max_lt <= '1' WHEN max_src < MemIn_out ELSE '0';
    -- compare min more than curr or not
    min_mt <= '1' WHEN min_src > MemIn_out ELSE '0';
	 
	 

    -- calculate final res
    sub <= max_out - min_out WHEN done = '1' ELSE 0;

    -- Register i
    REG_i: Regn 
    PORT MAP(
        RST, CLK ,
        ld_i,
        i_src,
        I
    );

    --Memory Input
    Mem_in: MemIn
    PORT MAP(
        CLK,
        I,
        mi_w_en,
        in_data,
        mi_r_en,
        MemIn_out
    );

    -- Register max
    REG_max: Regn 
    PORT MAP(
        RST, CLK ,
        ld_max,
        max_src,
        max_out
    );

    -- Register min
    REG_min: Regn 
    PORT MAP(
        RST, CLK ,
        ld_min,
        min_src,
        min_out
    );

    --Memory Output
    Mem_out: MemOut
    PORT MAP(
        CLK,
        mo_w_en,
        sub,
        mo_r_en,
        out_data
    );

    --Memory Size
    Mem_size: MemSize
    PORT MAP(
        CLK,
        size_w_en,
        Size_in,
        size_r_en,
        Size_out
    );
	 max_val <= max_out;
    min_val <= min_out;
END RTL;

