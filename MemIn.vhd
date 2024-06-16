
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY MemIn IS
PORT (
	CLK : IN std_logic; -- clock
	addr : IN integer; -- Address
	WE : IN std_logic; -- Write Enable
	Din : IN integer ; -- Input Data
	RE : IN std_logic; -- Read Enable
	Dout : OUT integer -- Output data
);
END MemIn;

ARCHITECTURE RTL OF MemIn IS
TYPE ARRAY_DATA IS ARRAY (0 TO 1024 - 1) OF Integer;
SIGNAL MemIn_Array : ARRAY_DATA := (
-93, -365, -64, -67, 264, -207, -495, -100, 178, -486 ,OTHERS => 0
);
BEGIN
-- Read/Write process
RW_Process : PROCESS (CLK)
BEGIN
 IF (CLK'event and CLK = '1') THEN -- rising clock edge
	IF WE = '1' THEN
		MemIn_Array(addr) <= Din;
	ELSIF RE = '1' THEN
		Dout <= MemIn_Array(addr);
	END IF;
 END IF;
END PROCESS RW_Process;
END RTL;