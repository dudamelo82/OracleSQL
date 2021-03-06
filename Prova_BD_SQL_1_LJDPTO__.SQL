/***********************************************************************/
/*            UNICEUB - CENTRO UNIVERSIT�RIO DE BRAS�LIA               */
/*                      PR�-REITORIA ACAD�MICA                         */
/*                        DIRETORIA ACAD�MICA                          */
/*    FACULDADE DE TECNOLOGIA E CI�NCIAS SOCIAIS APLICADAS - FATECS    */
/*CURSO SUPERIOR DE TECNOLOGIA EM AN�LISE E DESENVOLVIMENTO DE SISTEMAS*/
/*   DISCIPLINA DE BANCO DE DADOS - 2� BIM - TURMA: _____ - 2� PER     */
/*  Professor: DEUSDETH MARIANO         Data: __ de ________ de ____   */
/***********************************************************************/
/* RA: 21751177 Aluno: Cristiana Campos Cavallon______________________ */ 
/***********************************************************************/


-- QUEST�O 1) Criar os objetos de BD (tabela e constraints) dos 
--            itens abaixo de acordo com o MER entregue junto com a prova.
--
-- a. Criar a tabela SAIDA_MERCADORIA, associativa entre EMPREGADO, MERCADORIA
--    e ALMOXARIFADO. Na cria��o da tabela (mesmo comando) incluir as constraints de
--    PRIMARY KEY, DOM�NIO e NULIDADE, conforme nomes descritos no modelo.
-- RESOLU��O:

create table SAIDA_MERCADORIA (
    data                 DATE           not null,
    ALM_codigo           NUMBER         not null,
    MER_codigo           NUMBER         not null,
    quantidade           NUMBER(4)      not null,
    EMP_matricula        NUMBER         not null,
    CONSTRAINT PK_SAI_MER PRIMARY KEY(data,ALM_codigo,MER_codigo)
);

-- b. Criar as constraints das CHAVES ESTRANGEIRAS (foreing key) da tabela   
--    SAIDA_MERCADORIA com os nomes que est�o no MER f�sico.
-- RESOLU��O:

ALTER TABLE SAIDA_MERCADORIA
ADD CONSTRAINT FK_SAIMER_ALM FOREIGN KEY (ALM_codigo) REFERENCES ALMOXARIFADO (codigo);

ALTER TABLE SAIDA_MERCADORIA
ADD CONSTRAINT FK_SAIMER_MER FOREIGN KEY (MER_codigo) REFERENCES MERCADORIA (codigo);

ALTER TABLE SAIDA_MERCADORIA
ADD CONSTRAINT FK_SAIMER_EMP FOREIGN KEY (EMP_MATRICULA) REFERENCES empregado (matricula);

-- c. Criar uma constraint de CHECK de nome CK_SAIMER_QDE para que a coluna   
--    QUANTIDADE para n�o permitir valores negativos, zerado ou nulos.
-- RESOLU��O:

ALTER TABLE SAIDA_MERCADORIA
ADD CONSTRAINT CK_SAIMER_QDE CHECK (QUANTIDADE > 0);

-- d. Criar uma view de nome VW_ESTOQUE para mostrar o estoque de produto existente  
--    em cada ALMOXARIFADO das lojas (Considerar todos as mercadorias do cadastro): 
--    Colunas da view: nome do almoxarifado (ALMOX), descricao da mercadoria 
--    (MERCADORIA), quantidade que entrou (QDE_ENT), quantidade que saiu (QDE_SAI) 
--    e quantidade dispon�vel (QDE_DISP). Mostrar valores 0 (ZERO) quando n�o existir.
-- RESOLU��O:

select
      ALMOXARIFADO.NOME AS ALMOX,
      MERCADORIA.DESCRICAO AS MERCADORIA,
      SUM (ENTRADA_MERCADORIA.QUANTIDADE) AS QDE_ENT,
      SUM (SAIDA_MERCADORIA.QUANTIDADE) AS QDE_SAI,
      (SUM (ENTRADA_MERCADORIA.QUANTIDADE) - SUM (SAIDA_MERCADORIA.QUANTIDADE)) AS QDE_DISP
      
from ENTRADA_MERCADORIA join
      ALMOXARIFADO on ENTRADA_MERCADORIA.ALM_CODIGO=ALMOXARIFADO.CODIGO join
      MERCADORIA on ENTRADA_MERCADORIA.ALM_CODIGO=MERCADORIA.CODIGO LEFT JOIN
      (SAIDA_MERCADORIA JOIN
      ALMOXARIFADO ON SAIDA_MERCADORIA.CODIGO=ALMOXARIFADO.CODIGO JOIN
      MERCADORIA ON MERCADORIA.CODIGO=SAIDA_MERCADORIA.CODIGO)
GROUP BY
ALMOXARIFADO.NOME,
MERCADORIA.DESCRICAO;


-- QUEST�O 2) Inserir os seguintes dados na tabela criada: 
--
-- a. Inserir todos os registros da tabela SAI_MER pertencente ao usu�rio DEMO
--    (dispon�vel no BD para leitura) na tabela criada SAIDA_MERCADORIA.
-- RESOLU��O:

INSERT INTO SAIDA_MERCADORIA
SELECT *
FROM SAI_MER;

-- b. Inserir aos seguintes dados na tabela SAIDA_MERCADORIA: 
--    Codigo da mercadoria = 25
--    Quantidade de mercadoria = 222
--    Data de aquisi��o = '07/06/2016'
--    Almoxarifado = 1004
--    Empregado respons�vel = 11111
-- RESOLU��O:

INSERT INTO SAIDA_MERCADORIA VALUES ('07/06/2016',1004,25,222,11111);

-- QUEST�O 3) Alterar na tabela SAIDA_MERCADORIA o conte�do do campo QUANTIDADE 
--            para 444 da inclus�o realizada no item b. da QUEST�O 2).
-- RESOLU��O:

UPDATE SAIDA_MERCADORIA SET QUANTIDADE=4444 WHERE DATA='07/06/2016' AND ALM_CODIGO=1004 AND MER_codigo=25;

-- QUEST�O 4) Excluir na tabela SAIDA_MERCADORIA o registro inclu�do item b. da 
--            QUEST�O 2) ACIMA se a situa��o do almoxarifado for 'Ativo'. 
-- RESOLU��O:

DELETE FROM SAIDA_MERCADORIA 
WHERE DATA='07/06/2016' 
AND ALM_CODIGO=1004 
AND MER_codigo=25 
AND alm_codigo=(select alm_codigo from almoxarifado where situacao='Ativo' AND ALM_CODIGO=1004);

-- QUEST�O 5) Implementar as consultas (QUERY) para selecionar os dados 
--            correspondentes nas tabelas constantes do MER e BD disponibilizado
--            para a avalia��o: 
-- 
-- a. Selecionar as colunas (campos) dos �ndices relacionados com a tabela SAIDA_MERCADORIA.
--    Mostrar: Todas colunas ordenadas pelos nomes dos indices ascendente e pelos nomes das 
--    colunas descendentes.
-- RESOLU��O:

SELECT * 
FROM ALL_OBJECTS
WHERE OBJECT_NAME LIKE 'USER%MER';

SELECT * 
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'SAIDA_MERCADORIA'
ORDER BY 1,3 DESC;

-- b. Selecionar, distintamente, as mercadorias que possuem entradas em pelo menos
--    um almoxarifado.
--    Mostrar: CODIGO e DESCRICAO ordenados decrescente pela DESCRICAO da mercadoria.
-- RESOLU��O:

SELECT DISTINCT MERCADORIA.CODIGO,
MERCADORIA.DESCRICAO
FROM ENTRADA_MERCADORIA JOIN
MERCADORIA ON MERCADORIA.CODIGO=ENTRADA_MERCADORIA.MER_CODIGO
ORDER BY DESCRICAO DESC;
=============================================================================
-- SOLUCAO DO PROFESSOR
SELECT DISTINCT
FROM ENTRADA_MERCADORIA EM JOIN
    MERCADORIA M ON M.CODIGO=EM.MER_CODIGO
ORDER BY DESCRICAO DESC;  

-- c. Selecionar os empregados e seus respectivos registros de sa�das de mercadorias 
--    nos almoxarifados. Mostrar 0 (ZERO) para aqueles que n�o realizaram registros.
--    Mostrar: MATRICULA, NOME e quantidade de registros (QDE_R), ordenado 
--             decrescente pela QDE_R.
-- RESOLU��O:
SELECT EMPREGADO.MATRICULA,
        EMPREGADO.NOME,
        NVL(COUNT(SAIDA_MERCADORIA.EMP_MATRICULA),0) AS QDE_R
FROM EMPREGADO LEFT JOIN
SAIDA_MERCADORIA ON EMPREGADO.MATRICULA=SAIDA_MERCADORIA.EMP_MATRICULA
GROUP BY 
EMPREGADO.MATRICULA,
EMPREGADO.NOME
ORDER BY QDE_R DESC;

=============================================================================
-- SOLUCAO DO PROFESSOR
SELECT E.MATRICULA,
       E.NOME 
       NVL (COUNT (SM.EMP_MATRICULA),0) AS QDE_R
FROM EMPREGADO E LEFT JOIN
        SAIDA_MERCADORIA SM ON E.MATRICULA=SM.EMP_MATRICULA
GROUP BY E.MATRICULA,
        E.NOME
ORDER BY QDE_R DESC;
