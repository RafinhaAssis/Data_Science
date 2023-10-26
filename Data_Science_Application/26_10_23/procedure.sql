/*
Bloco anonimos:

São trechos de código não armazenado, executa uma vez e desaparecem. Ou seja:

--> Não tem reuso
--> Não tem toda a parte do parse/ compilacao: O Oracle compila
e verifica a existencia dos objetos toda vez.
--> Por ser feito em uma ferramenta de desenvolvedor, os acessos para execução dele são em desenvolvimentos.

---> ESQUELETO <---
<DECLARE>
BEGIN
<exception>
END


Procedures/ Funcoes/ Triggers/ Views
São trechos de código armazenados. Ou seja:

--> Reuso
--> Performance (Já parseados e compilados gerando P-CODE)
--> Dando as permissões corretas (grants) um usuario pode executar esse trecho de código

--> PROCEDURE <--

---> ESQUELETO <---
CREATE <OR REPLACE> <NAME>
IS
BEGIN
<EXCEPTION>
END <NAME>;


*/
--> ALGORITIMO QUE CALCULE O NÚMERO ELEVADO A DOIS
--> Com Bloco anonimo

SET SERVEROUTPUT ON
ACCEPT ANUM NUMBER PROMPT 'dIGITE UM VALOR';
DECLARE
    NUMERO INTEGER := &ANUM;
    QUAD INTEGER;
BEGIN
    QUAD := NUMERO * NUMERO;
    DBMS_OUTPUT.PUT_LINE('O QUAD DO NUMERO'|| NUMERO ||' É ' || QUAD);
END;

--> Com procedure
/*
DROP PROCEDURE QUADR;
CREATE OR REPLACE PROCEDURE QUADR
--> IS ATUA COMO O DECLARE DOS BLOCOS ANONIMOS;
IS
    NUMERO INTEGER := 99;
    QUADRADO INTEGER;
BEGIN
    QUADRADO := NUMERO * NUMERO;
    DBMS_OUTPUT.PUT_LINE('O QUAD DO NUMERO'|| NUMERO ||' É ' || QUADRADO);
END QUADR;

EXECUTE QUADR;
*/

--> EXERCICIO 1: CRIA MÉDIA DE DOIS VALORES:
--> Procedure não aceita accept
CREATE OR REPLACE PROCEDURE media (pnum in float, pnum2 in float)
--> IS ATUA COMO O DECLARE DOS BLOCOS ANONIMOS;
IS
    NUMERO float := pnum;
    NUMERO2 float := pnum2;
    media float;
BEGIN
    media := (NUMERO + NUMERO2)/2;
    DBMS_OUTPUT.PUT_LINE('Media ' || media);
END media;

EXECUTE media(5.5);

-->> Melhorando o exercicio:
CREATE OR REPLACE PROCEDURE media (pnum in float, pnum2 in float default 100)
IS
    NUMERO float := pnum;
    NUMERO2 float := pnum2;
    media float;
BEGIN
    media := (NUMERO + NUMERO2)/2;
    DBMS_OUTPUT.PUT_LINE('Media ' || media);
END media;


--> USANDO ACCEPT
ACCEPT ANUM1 NUMBER PROMPT 'DIGITE O PRIMEIRO VALOR'
ACCEPT ANUM2 NUMBER PROMPT 'DIGITE O SEGUNDO VALOR'
EXECUTE MEDIA(&ANUM1, &ANUM2);


--> vISUALIZANDO ERROS: MOSTRA O ERRO DA ULTIMA PROCEDURE EXECUTADA:

sHOW ERRORS;
SHOW ERRORS PROCEDURE MEDIA;

DESC USER_ERRORS;
SELECT TEXT FROM USER_ERRORS WHERE NAME = 'media';

--> Maneiras alternativas de chamar uma procedure

---> Posicional:
    EXECUTE MEDIA(100,22);
---> Nominal:
    EXECUTE MEDIA(pnum2 => 55, pnum => 22);
    
    
    




--> 
CREATE OR REPLACE PROCEDURE P_REAJUSTE_SALARIO(
PEMPNO EMP.EMPNO%TYPE,
AJUSTE NUMBER DEFAULT 10)
IS
BEGIN
    UPDATE EMP SET SAL = (SAL+((SAL * AJUSTE)/100)) WHERE EMPNO = PEMPNO;
END P_REAJUSTE_SALARIO;
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO = 7839;
EXECUTE P_REAJUSTE_SALARIO(PEMPNO => 7839, AJUSTE => 5);
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO = 7839;

ROLLBACK;



--> Bloco anonimo para executar um select
SET SERVEROUTPUT ON
ACCEPT AEMPNO NUMBER PROMPT 'Entre com o código do empregado:'
DECLARE
    LEMP EMP%ROWTYPE;
    
BEGIN
    lemp.empno := &AEMPNO;
    SELECT EMPNO, ENAME, SAL
    INTO LEMP.EMPNO, LEMP.ENAME, LEMP.SAL
    FROM EMP WHERE EMPNO = LEMP.empno;
    dbms_output.put_line('O empregado: ' || LEMP.ENAME || 'ganha: ' || lEMP.SAL );
END;


--> TRANSFORMANDO O BLOCO ANONIMO EM PROCEDURE:
CREATE OR REPLACE PROCEDURE P_CONS_EMP(PEMPNO IN EMP.EMPNO%TYPE ) IS 
    LEMP EMP%ROWTYPE;
BEGIN
    SELECT EMPNO, ENAME, SAL
    INTO LEMP.EMPNO, LEMP.ENAME, LEMP.SAL
    FROM EMP WHERE EMPNO = PEMPNO;
    dbms_output.put_line('O empregado: ' || LEMP.ENAME || ' ganha: ' || lEMP.SAL );
END P_CONS_EMP;

EXECUTE P_CONS_EMP(7839)

--> Chamando atravez de bloco anonimos:
ACCEPT AEMPNO NUMBER PROMPT 'Entre com o código do empregado:' 
begin
    P_CONS_EMP(&AEMPNO);
end;

--> Nova construção:
CREATE OR REPLACE PROCEDURE P_CONS_EMP(PEMPNO IN out  EMP.EMPNO%TYPE, pename out emp.ename%type, psal out emp.sal%type ) IS 
BEGIN
    SELECT EMPNO, ENAME, SAL
    INTO pEMPNO,pENAME,pSAL
    FROM EMP WHERE EMPNO = PEMPNO;
    --dbms_output.put_line('O empregado: ' || pENAME || ' ganha: ' || pSAL );
END P_CONS_EMP;


ACCEPT aempno NUMBER PROMPT 'Entre com o codigo do empregado';
DECLARE
    lemp emp%ROWTYPE;
BEGIN
    lemp.empno :=&aempno;
    P_CONS_EMP(lemp.empno, lemp.ename, lemp.sal);    
    DBMS_OUTPUT.PUT_LINE('O empregado ' || lemp.ename || ' ganha '||lemp.sal ||' doletas');
END;





