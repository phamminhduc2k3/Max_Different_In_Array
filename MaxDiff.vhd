LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE work.MyLib.all;

ENTITY MaxDiff IS
PORT (
	RST, CLK : IN STD_LOGIC;
	Start_i : IN STD_LOGIC;
	max_val, min_val : OUT INTEGER;
	Done_o : OUT STD_LOGIC
);
END MaxDiff;

ARCHITECTURE MaxDiff_Arch OF MaxDiff IS
SIGNAL sel_i, sel_max, sel_min : STD_LOGIC;
SIGNAL i_lt, max_lt, min_mt: STD_LOGIC;
SIGNAL ld_i, ld_max, ld_min : STD_LOGIC;
SIGNAL mi_r_en, mi_w_en, mo_w_en, mo_r_en, size_r_en, size_w_en: STD_LOGIC;
BEGIN

CTRL_unit: Controller
PORT MAP(
	RST, CLK,
	Start_i,

    i_lt, max_lt, min_mt,

    ld_i, ld_max, ld_min,
    sel_i, sel_max, sel_min,

 	mi_r_en, mi_w_en,
	mo_r_en, mo_w_en,
	size_r_en, size_w_en,

	Done_o
);

Datapath_Unit: Datapath
PORT MAP(
    RST, CLK,
    ld_i, ld_max, ld_min,
    i_lt, max_lt, min_mt,
    sel_i, sel_max, sel_min,
    mi_r_en, mi_w_en,
    mo_r_en, mo_w_en,
    size_r_en, size_w_en,
	 max_val,min_val 
);
END MaxDiff_Arch;

