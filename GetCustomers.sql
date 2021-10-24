DELIMITER //

DROP PROCEDURE IF EXISTS GetCustomers;

CREATE PROCEDURE GetCustomers()
BEGIN

     	DECLARE finished INTEGER DEFAULT 0;
	DECLARE nameEmployee VARCHAR(500);
	DECLARE timeMO VARCHAR(11);
	DECLARE timeTU VARCHAR(11);
	DECLARE timeWE VARCHAR(11);
	DECLARE timeTH VARCHAR(11);
	DECLARE timeFR VARCHAR(11);
	DECLARE timeSA VARCHAR(11);
	DECLARE timeSU VARCHAR(11);

	-- declare cursor to read information of employees
        DECLARE cur1 CURSOR FOR SELECT name,IFNULL(mo,0),IFNULL(tu,0),IFNULL(we,0),IFNULL(th,0),IFNULL(fr,0),IFNULL(sa,0),IFNULL(su,0) FROM mytest.result;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET finished = 1;  

	OPEN cur1;
	REPEAT
 		FETCH cur1 INTO nameEmployee,timeMO,timeTU,timeWE,timeTH,timeFR,timeSA,timeSU;
		IF NOT finished THEN
		INSERT INTO final
		    SELECT name,nameEmployee,
            		   IF(ISNULL(NULLIF(timeMO,mo)),1,0)+
            		   IF(ISNULL(NULLIF(timeTU,tu)),1,0)+
	    		   IF(ISNULL(NULLIF(timeWE,we)),1,0)+
	    		   IF(ISNULL(NULLIF(timeTH,th)),1,0)+
	    		   IF(ISNULL(NULLIF(timeFR,fr)),1,0)+
            		   IF(ISNULL(NULLIF(timeSA,sa)),1,0)+
            		   IF(ISNULL(NULLIF(timeSU,su)),1,0) as assist
 		     FROM result
		    WHERE NOT EXISTS (SELECT employee1, employee2 
                                        FROM final 
                                       WHERE (employee1 IN (nameEmployee,name)) 
                                         AND (employee2 IN (nameEmployee,name)))
                      AND name <> nameEmployee;
		END IF;
	UNTIL finished END REPEAT;
	CLOSE cur1;
	SELECT * FROM final;


END;
//
DELIMITER ;
