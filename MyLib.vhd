LIBRARY IEEE;
USE ieee.std_logic_1164.all;

PACKAGE MyLib IS 

--8bits register
COMPONENT Regn IS
PORT (
	RST, CLK : IN STD_LOGIC;
	En : IN STD_LOGIC;
	D : IN INTEGER;
	Q : OUT INTEGER
);
END COMPONENT;

--Matrix input
COMPONENT MemIn IS
PORT (
	CLK  : IN std_logic; -- clock
	addr : IN integer; -- Address
	WE   : IN std_logic; -- Write Enable
	Din  : IN integer ; -- Input Data
	RE   : IN std_logic; -- Read Enable
	Dout : OUT integer -- Output data
);
END COMPONENT;

COMPONENT MemOut IS
PORT (
	CLK : IN std_logic; -- clock
	WE : IN std_logic; -- Write Enable
	Din : IN integer ; -- Input Data
	RE : IN std_logic; -- Read Enable
	Dout : OUT integer -- Output data
);
END COMPONENT;

COMPONENT MemSize IS
PORT (
	CLK : IN std_logic; -- clock
	WE : IN std_logic; -- Write Enable
	Din : IN integer ; -- Input Data
	RE : IN std_logic; -- Read Enable
	Dout : OUT integer -- Output data
);
END COMPONENT;

COMPONENT Datapath IS
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
END COMPONENT;

COMPONENT Controller IS
PORT (
	RST, CLK : IN STD_LOGIC;
	Start_i : IN STD_LOGIC;

    i_lt, max_lt, min_mt: IN STD_LOGIC;

    ld_i, ld_max, ld_min: OUT STD_LOGIC;
    sel_i, sel_max, sel_min: OUT STD_LOGIC;

 	mi_r_en, mi_w_en : OUT STD_LOGIC;
	mo_r_en, mo_w_en : OUT STD_LOGIC;
	size_r_en, size_w_en: OUT STD_LOGIC;

	Done_o : OUT STD_LOGIC
);
END COMPONENT;

COMPONENT MaxDiff IS
PORT (
	RST, CLK : IN STD_LOGIC;
	Start_i : IN STD_LOGIC;
	Done_o : OUT STD_LOGIC
);
END COMPONENT;

END MyLib;
