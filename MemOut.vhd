LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY MemOut IS
PORT (
	CLK : IN std_logic; -- clock
	WE : IN std_logic; -- Write Enable
	Din : IN Integer ; -- Input Data
	RE : IN std_logic; -- Read Enable
	Dout : OUT integer -- Output data
);
END MemOut;

ARCHITECTURE RTL OF MemOut IS

SIGNAL M_Out : Integer;

BEGIN -- memoryIn_arch
-- Read/Write process
RW_Process : PROCESS (CLK)
BEGIN
 IF (CLK'event and CLK = '1') THEN -- rising clock edge
	IF WE = '1' THEN
        M_Out <= Din;
	ELSIF RE = '1' THEN
		Dout <= M_Out;
	END IF;
 END IF;
END PROCESS RW_Process;
END RTL;
