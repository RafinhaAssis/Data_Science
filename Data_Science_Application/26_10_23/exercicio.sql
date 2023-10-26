--> Fun��es:

CREATE OR REPLACE FUNCTION FUNCAO
RETURN NUMBER 
IS 
    NUMERO INTEGER := 5;
    QUADRADO INTEGER;
BEGIN
    QUADRADO := NUMERO * NUMERO;
    RETURN QUADRADO;
END FUNCAO;

SELECT FUNCAO FROM DUAL;

SELECT ENAME, FUNCAO FROM EMP;


/*
Escreva um procedure PR_RECUPERA_LIVROS que recupere TODOS os LIVROS da tabela T_BS _LIVRO e exiba na tela. Trate a exce��o se n�o houver dados na tabela. 
*/
CREATE OR REPLACE PROCEDURE PR_RECUPERA_LIVROS IS
CURSOR C_LIVRO IS
        SELECT * FROM
        T_BS_LIVRO;
        V_ROW T_BS_LIVRO%ROWTYPE;
BEGIN
OPEN C_LIVRO;
        LOOP
            FETCH C_lIVRO INTO V_ROW.CD_CODIGO,
            V_ROW.TX_TITULO,
            V_ROW.NR_NUMERO_PAGINAS,
            V_ROW.NR_ANO_PUBLICACAO,
            V_ROW.NR_EDICAO,
            V_ROW.CD_AUTOR;
            EXIT WHEN C_LIVRO%NOTFOUND;
            dbms_output.put_line(' ' || V_ROW.CD_CODIGO || ' ' ||  V_ROW.TX_TITULO || ' ' || V_ROW.NR_NUMERO_PAGINAS || ' ' || V_ROW.NR_ANO_PUBLICACAO ||' ' || V_ROW.NR_EDICAO || ' ' || V_ROW.CD_AUTOR);
        END LOOP;
        CLOSE C_LIVRO;
END PR_RECUPERA_LIVROS;

EXECUTE PR_RECUPERA_LIVROS;

--> GLOBAL SOLUTIONS CURSOR, PROCEDURES E BLOCOS ANONIMOS. 