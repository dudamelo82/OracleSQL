/***********************************************************************/
/*            UNICEUB - CENTRO UNIVERSITÁRIO DE BRASÍLIA               */
/*                      PRÓ-REITORIA ACADÊMICA                         */
/*                        DIRETORIA ACADÊMICA                          */
/*    FACULDADE DE TECNOLOGIA E CIÊNCIAS SOCIAIS APLICADAS - FATECS    */
/*CURSO SUPERIOR DE TECNOLOGIA EM ANÁLISE E DESENVOLVIMENTO DE SISTEMAS*/
/*   DISCIPLINA DE BANCO DE DADOS - 2° BIM - TURMA: _____ - 2º PER     */
/*  Professor: DEUSDETH MARIANO         Data: __ de ________ de ____   */
/***********************************************************************/
/* RA:__________ Aluno: ______________________________________________ */ 
/***********************************************************************/

-- QUESTÃO 1) Criar os objetos de BD (tabela e constraints) dos 
--            itens abaixo de acordo com o MER entregue junto com a prova.
--
-- a. Criar a tabela MERCADORIA_ENTRADA , associativa entre FABRICA_EXT, 
--    MERCADORIA e ARMAZEM. Na criação da tabela (mesmo comando) incluir as 
--    constraints de PRIMARY KEY, DOMÍNIO e NULIDADE, conforme nomes descritos no 
--    modelo.
-- RESOLUÇÃO:

CREATE TABLE MERCADORIA_ENTRADA (
  DATA                  DATE                            not null,
  MER_CODIGO            NUMBER                          not null,
  ARM_ID                NUMBER                          not null,
  QUANTIDADE            NUMBER(4)                       not null,
  FAB_ID                NUMBER,
  CONSTRAINT PK_MERCADORIA_ENTRADA PRIMARY KEY (DATA, MER_CODIGO, ARM_ID)
);

SELECT*
FROM MERCADORIA_ENTRADA;

DROP TABLE MERCADORIA_ENTRADA;

----------------------------------------------
CREATE TABLE ARMAZEM (
ID                   NUMBER,
NOME                 VARCHAR2(60)  NOT NULL,
RUA                  VARCHAR2(100) NOT NULL,
NR                   VARCHAR2(10)  NOT NULL,
BAIRRO               VARCHAR2(50)  NOT NULL,
CIDADE               VARCHAR2(30)  NOT NULL,
UF                   VARCHAR2(30)  NOT NULL,
SITUACAO             VARCHAR2(7)   NOT NULL,
CONSTRAINT PK_ARMAZEM PRIMARY KEY (ID)
);

SELECT *
FROM ARMAZEM;

DROP TABLE ARMAZEM;
-----------------------------------------------
CREATE TABLE MERCADORIA (
CODIGO              NUMBER,
DESCRICAO           VARCHAR2(100)   NOT NULL,
UNIDADE_MEDIDA      VARCHAR2(10)    NOT NULL,
CONSTRAINT PK_MERCADORIA PRIMARY KEY (CODIGO)
);

SELECT *
FROM MERCADORIA;

DROP TABLE MERCADORIA;

--------------------------------------------------
CREATE TABLE FABRICA_EXT (
ID                 NUMBER,
NOME               VARCHAR2(100)    NOT NULL,
CONSTRAINT PK_FABRICA_EXT PRIMARY KEY (ID)
);

SELECT *
FROM FABRICA_EXT;

DROP TABLE FABRICA_EXT;

-------------------------------------------
CREATE TABLE MERCADORIA_SAIDA (
DATA            DATE,
ARM_ID          NUMBER,
MER_CODIGO      NUMBER,
QUANTIDADE      NUMBER  NOT NULL,
FUN_REGISTRO    NUMBER  NOT NULL,
CONSTRAINT PK_MERCADORIA_SAIDA PRIMARY KEY (DATA, ARM_ID, MER_CODIGO)
);

SELECT *
FROM MERCADORIA_SAIDA;

DROP TABLE MERCADORIA_SAIDA;

------------------------------------------
CREATE TABLE FUNCIONARIO (
REGISTRO NUMBER,
NOME VARCHAR2(100),
FUNCAO VARCHAR(200),
CONSTRAINT PK_FUNCIONARIO PRIMARY KEY (REGISTRO)
);

SELECT *
FROM FUNCIONARIO;

DROP TABLE FUNCIONARIO;




-- b. Criar as constraints das CHAVES ESTRANGEIRAS (foreing key) da tabela   
--    MERCADORIA_ENTRADA com os nomes que estão no MER físico.
-- RESOLUÇÃO:
ALTER TABLE MERCADORIA_ENTRADA
ADD CONSTRAINT FK_MERCADORIA_ENTRADA FOREIGN KEY (MER_CODIGO) REFERENCES MERCADORIA (CODIGO);




--    c. Criar as constraints de chave primaria (primary key) para as tabelas associativas.
-- RESOLUÇÃO:

ALTER TABLE MERCADORIA_ENTRADA
ADD CONSTRAINT PK_MER_ENT PRIMARY KEY (DATA, MER_CODIGO, ARM_ID);



ALTER TABLE FABRICA_EXT
ADD CONSTRAINT PK_FAB PRIMARY KEY ( PK_FAB);


ALTER TABLE MERCADORIA 
ADD CONSTRAINT PK_MER  PRIMARY KEY ( CODIGO);


ALTER TABLE ARMAZEM
ADD CONSTRAINT PK_ARM PRIMARY KEY ( ID);



-- c. Criar uma constraint de CHECK de nome CK_MERENT_QDE para que a coluna   
--    QUANTIDADE para não permitir valores negativos, zerado ou nulos.
-- RESOLUÇÃO:


-- d. Criar uma view de nome VW_ESTOQUE para mostrar o estoque de produto existente  
--    em cada ARMAZEM das lojas (Considerar todos as mercadorias do cadastro): 
--    Colunas da view: nome do armazem (ARMAZ), descricao da mercadoria 
--    (PRODUTO), quantidade que entrou (QTD_ENT), quantidade que saiu (QTD_SAI) 
--    e quantidade disponível (QTD_DISP). Mostrar valores 0 (ZERO) quando não existir.
-- RESOLUÇÃO:
CREATE OR REPLACE VIEW VIEW_ESTOQUE;



-- QUESTÃO 2) Inserir os seguintes dados na tabela criada: 
--
-- a. Inserir todos os registros da tabela MER_ENT pertencente ao usuário DEMO
--    (disponível no BD para leitura) na tabela criada MERCADORIA_ENTRADA.
-- RESOLUÇÃO:

INSERT INTO MERCADORIA_ENTRADA
SELECT * 
FROM DEMO.MERCADORIA_ENTRADA;

-- b. Inserir aos seguintes dados na tabela MERCADORIA_ENTRADA: 
--    Codigo da mercadoria = 19
--    Quantidade de mercadoria = 123
--    Data de aquisição = '05/04/2015'
--    Almoxarifado = 1003
--    Fabricante = 105
-- RESOLUÇÃO:
INSERT INTO MERCADORIA_ENTRADA VALUES('05/04/2015',19, 1003,123, 105);

-- QUESTÃO 3) Alterar na tabela MERCADORIA_ENTRADA o conteúdo do c,ampo QUANTIDADE 
--            para 321 da inclusão realizada no item b. da QUESTÃO 2).
-- RESOLUÇÃO:



-- QUESTÃO 4) Excluir na tabela MERCADORIA_ENTRADA o registro incluído item b. da 
--            QUESTÃO 2) ACIMA se a situação do armazem for 'Inativo'. 
-- RESOLUÇÃO:

DELETE FROM


-- QUESTÃO 5) Implementar as consultas (QUERY) para selecionar os dados 
--            correspondentes nas tabelas constantes do MER e BD disponibilizado
--            para a avaliação: 
-- 
-- a. Selecionar as mercadorias distintas que deram entradas mas não deram nenhuma  
--    saída dos armazéns.  
--    Mostrar: CODIGO e DESCRICAO ordenados decrescente pelo CODIGO da mercadoria.
-- RESOLUÇÃO:
-- NÃO SEI SE TA CERTO ESSA PORRAAA!!!! EDITAD DA SOLUCAO DELE PROVA 1
SELECT DISTINCT MERCADORIA.CODIGO,
MERCADORIA.DESCRICAO
FROM SAIDA_MERCADORIA EM JOIN
MERCADORIA ON MERCADORIA.CODIGO=SAIDA_MERCADORIA.MER_CODIGO
ORDER BY CODIGO DESC;

SELECT DISTINCT
FROM SAIDA_MERCADORIA SM JOIN
    MERCADORIA M ON M.CODIGO=SM.MER_CODIGO
    ORDER BY DESCRICAO DESC;
-- NÃO SEI SE TA CERTO ESSA PORRAAA!!!!

-- b. Selecionar as fabricas externas e seus respectivos fornecimentos de mercadorias 
--    nos armazens. Mostrar 0 (ZERO) para aquelas que não realizaram fornecimentos.
--    Mostrar: ID, NOME e quantidade de fornecimentos (QDE_F), ordenado 
--             crescente pela QDE_F.
-- RESOLUÇÃO:

-- NÃO SEI SE TA CERTO ESSA PORRAAA!!!!EDITAD DA SOLUCAO DELE PROVA 1
SELECT FABRICA.ID,
        FABRICA.NOME,
        NVL(COUNT(SAIDA_MERCADORIA.FAB_ID),0) AS QDE_F
FROM FABRICA LEFT JOIN
SAIDA_MERCADORIA ON FABRICA.ID=SAIDA_MERCADORIA.FAB_ID
GROUP BY 
FABRICA.ID,
FABRICA.NOME
ORDER BY QDE_F ASC;
-- NÃO SEI SE TA CERTO ESSA PORRAAA!!!!EDITAD DA SOLUCAO DELE PROVA 1

-- c. Selecionar as colunas (campos) dos índices relacionados com a tabela MERCADORIA_ENTRADA.
--    Mostrar: Todas colunas ordenadas pelos nomes dos indices descendente e nomes das colunas
--             ascendentes.
-- RESOLUÇÃO:

SELECT*
FROM ALL_OBJECTS
WHERE OBJECT_NAME LIKE 'U%COL%';


SELECT* 
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'PEDIDO'
ORDER BY 1,3 ASC;

SELECT* 
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'PEDIDO'
ORDER BY 1,3 DESC;




