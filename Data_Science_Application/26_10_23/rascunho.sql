SELECT * FROM DEPT;
SELECT * FROM EMP;

SELECT EMPNO, ENAME, SAL FROM EMP;
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO = 7839;
SELECT EMPNO, ENAME, (SAL+((SAL * 10)/100)) AS "AJUSTADO" FROM EMP WHERE EMPNO = 7839;
UPDATE EMP
SET SAL = (SAL+((SAL * 10)/100))
WHERE EMPNO = 7839;
ROLLBACK;

SELECT E.ENAME,E.SAL, D.DNAME FROM EMP E INNER JOIN DEPT D ON 
e.deptno = d.deptno;