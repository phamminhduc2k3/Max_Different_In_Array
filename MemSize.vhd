LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY MemSize IS
PORT (
	CLK : IN std_logic; -- clock
	WE : IN std_logic; -- Write Enable
	Din : IN integer ; -- Input Data
	RE : IN std_logic; -- Read Enable
	Dout : OUT integer -- Output data
);
END MemSize;

ARCHITECTURE RTL OF MemSize IS

SIGNAL Size : Integer := 10;

BEGIN
-- Read/Write process
RW_Process : PROCESS (CLK)
BEGIN
 IF (CLK'event and CLK = '1') THEN -- rising clock edge
	IF WE = '1' THEN
        	Size <= Din;
	ELSIF RE = '1' THEN
		Dout <= Size;
	END IF;
 END IF;
END PROCESS RW_Process;
END RTL;
