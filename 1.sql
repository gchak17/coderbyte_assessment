CREATE TABLE EMPS (
  ID INTEGER PRIMARY KEY, NAME TEXT, DIVISIONID INTEGER, 
  MANAGERID INTEGER, SAL INTEGER
);
CREATE TABLE DIVS (
  ID INTEGER PRIMARY KEY, DIVNAME TEXT
);
INSERT INTO EMPS 
VALUES 
  (1, 'emp1', 1, 2, 1000), 
  (2, 'emp2', 1, 3, 900), 
  (3, 'emp3', 2, 4, 800), 
  (4, 'emp4', 3, NULL, 700);
INSERT INTO DIVS 
VALUES 
  (1, 'div1'), 
  (2, 'div2'), 
  (3, 'div3');
  
/* notoptimal */
SELECT 
  t1.ID, 
  t1.NAME, 
  t2.DIVNAME divis, 
  (
    SELECT 
      NAME 
    FROM 
      EMPS 
    WHERE 
      ID = t1.MANAGERID
  ) man2, 
  t1.SAL salary 
FROM 
  EMPS t1 
  JOIN DIVS t2 ON t2.ID = t1.DIVISIONID 
ORDER BY 
  t1.SAL DESC 
LIMIT 
  1 offset 2;
  
/* better */
SELECT 
  t1.ID, 
  t1.NAME, 
  t2.DIVNAME divis, 
  t3.NAME manager, 
  t1.SAL salary 
FROM 
  EMPS t1 
  JOIN DIVS t2 ON t2.ID = t1.DIVISIONID 
  LEFT JOIN EMPS t3 ON t3.ID = t1.MANAGERID 
ORDER BY 
  t1.SAL DESC 
LIMIT 
  1 offset 2;
