DELIMITER $$

DROP PROCEDURE IF EXISTS GetCustomers$$

CREATE PROCEDURE GetCustomers()
BEGIN
	DECLARE contentReg VARCHAR(500);
	DECLARE nameEmployee VARCHAR(10);
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE timeMO VARCHAR(5);
	DECLARE timeTU VARCHAR(5);
	DECLARE timeWE VARCHAR(5);
	DECLARE timeTH VARCHAR(5);
	DECLARE timeFR VARCHAR(5);
	DECLARE timeSA VARCHAR(5);
	DECLARE timeSU VARCHAR(5);

	-- declare cursor to read information of employees
        DECLARE cur1 CURSOR FOR SELECT registro FROM mytest.cargaIncial;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	-- Permanently remove data in employTime table
	DROP TABLE IF EXISTS employTime;

	OPEN cur1;

	getRecord: LOOP
		FETCH cur1 INTO contentReg;
		IF finished = 1 THEN 
			LEAVE getRecord;
		END IF;
		-- Structure names and assistence
		SELECT LEFT(contentReg,SELECT INSTR(contentReg,'=')-1) INTO nameEmployee;

		-- Records time and hours by Monday
		SELECT IF(INSTR(contentReg,'MO')>0,SUBSTRING(contentReg,INSTR(contentReg,'MO')+2,10),'') INTO timeMO;
		-- Records time and hours by Tusday
--		SELECT IF(INSTR(contentReg,'TU')>0,SUBSTRING(contentReg,INSTR(contentReg,'TU')+2,10),'') INTO timeTU;
		-- Records time and hours by Wednesday
--		SELECT IF(INSTR(contentReg,'WE')>0,SUBSTRING(contentReg,INSTR(contentReg,'WE')+2,10),'') INTO timeWE;
		-- Records time and hours by Thursday
--		SELECT IF(INSTR(contentReg,'TH')>0,SUBSTRING(contentReg,INSTR(contentReg,'TH')+2,10),'') INTO timeTH;
		-- Records time and hours by Friday
--		SELECT IF(INSTR(contentReg,'FR')>0,SUBSTRING(contentReg,INSTR(contentReg,'FR')+2,10),'') INTO timeFR;
		-- Records time and hours by Saturday
--		SELECT IF(INSTR(contentReg,'SA')>0,SUBSTRING(contentReg,INSTR(contentReg,'SA')+2,10),'') INTO timeSA;
		-- Records time and hours by Sunday
--		SELECT IF(INSTR(contentReg,'SU')>0,SUBSTRING(contentReg,INSTR(contentReg,'SU')+2,10),'') INTO timeSU;

		-- Save records a Table
		INSERT INTO employTime VALUES (nameEmployee, timeMO, timeTU, timeWE, timeTH, timeFR, timeSA, timeSU);
	END LOOP getRecord;
	CLOSE cur1;


END$$
DELIMITER ;
