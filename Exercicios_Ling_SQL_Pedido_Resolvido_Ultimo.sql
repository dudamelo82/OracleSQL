/***********************************************************************/
/*                 CENTRO UNIVERSITÁRIO DE BRASÍLIA                    */
/*  CURSO SUPERIOR TECNOLOGIA EM ANÁLISE E DESENVOLVIMENTO DE SISTEMAS */
/*                    DISCIPLINA DE BANCO DE DADOS                     */
/*                            LINGUAGEM SQL                            */
/***********************************************************************/
-- QUESTÃO 1) Criar as tabelas do MER_Fisico_Pjt_BD_Pedido.
--    a. Script DDL para criar as tabelas do BD de pedidos: CLIENTE, PF, PJ, PRODUTO, FONE_CLIENTE,
--       FONE_VENEDOR, PRATELEIRA e VENDEDOR. Colocar as regras de integridade no script de criação.
-- SOLUÇÃO:

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
DROP TABLE CLIENTE CASCADE CONSTRAINT;

create table CLIENTE  (
   CODIGO               INTEGER                         not null,
   NOME                 varchar2(60)                    not null,
   RUA                  varchar2(80)                    not null,
   NR                   NUMBER(4)                       not null,
   BAIRRO               varchar2(50)                    not null,
   COMPLEMENTO          varchar2(100),
   CIDADE               varchar2(50)                    not null,
   UF                   varchar2(2)                     not null,
   CEP                  varchar2(10)                     not null,
   constraint PK_CLIENTE primary key (CODIGO)
);

/*==============================================================*/
/* Table: VENDEDOR                                              */
/*==============================================================*/
DROP TABLE VENDEDOR CASCADE CONSTRAINT;

create table VENDEDOR  (
   MATRICULA            INTEGER                         not null,
   NOME                 varchar2(60)                    not null,
   CNPF                 varchar2(14)                    not null,
   constraint PK_VENDEDOR primary key (MATRICULA)
);

/*==============================================================*/
/* Table: FONE_CLIENTE                                          */
/*==============================================================*/
DROP TABLE FONE_CLIENTE CASCADE CONSTRAINT;

create table FONE_CLIENTE  (
   NUMERO               varchar2(14)                    not null,
   CODIGO_CLI           INTEGER                         not null,
   constraint PK_FONE_CLIENTE primary key (NUMERO, CODIGO_CLI),
   constraint FK_FONE_CLIENTE foreign key (CODIGO_CLI) references CLIENTE (CODIGO)
);

/*==============================================================*/
/* Table: FONE_VENDEDOR                                         */
/*==============================================================*/
DROP TABLE FONE_VENDEDOR CASCADE CONSTRAINT;

create table FONE_VENDEDOR  (
   NUMERO               varchar2(14)                    not null,
   MATRICULA_VEN        INTEGER                         not null,
   constraint PK_FONE_VENDEDOR primary key (NUMERO, MATRICULA_VEN),
   constraint FK_FONE_VENDEDOR foreign key (MATRICULA_VEN) references VENDEDOR (MATRICULA)
);

/*==============================================================*/
/* Table: PF                                                    */
/*==============================================================*/
DROP TABLE PF;

create table PF  (
   CODIGO_CLI           INTEGER                         not null,
   CNPF                 varchar2(14)                    not null,
   RG                   varchar2(10)                    not null,
   DATA_NASCIMENTO      DATE                            not null,
   constraint PK_PF primary key (CODIGO_CLI),
   constraint FK_PF_CLIENTE foreign key (CODIGO_CLI) references CLIENTE (CODIGO)
);

/*==============================================================*/
/* Table: PJ                                                    */
/*==============================================================*/
DROP TABLE Pj;

create table PJ  (
   CODIGO_CLI           INTEGER                         not null,
   CNPJ                 varchar2(19)                    not null,
   IE                   varchar2(10)                    not null,
   NOME_FANTASIA        varchar2(60)                    not null,
   constraint PK_PJ primary key (CODIGO_CLI),
   constraint FK_PJ_CLIENTE foreign key (CODIGO_CLI) references CLIENTE (CODIGO)
);

/*==============================================================*/
/* Table: PRATELEIRA                                            */
/*==============================================================*/
DROP TABLE PRATELEIRA CASCADE CONSTRAINT;
create table PRATELEIRA  (
   CODIGO               NUMBER(3)                       not null,
   DESCRICAO            varchar2(50)                    not null,
   NUMERO_SECOES        NUMBER(2)                       not null,
   constraint PK_PRATELEIRA primary key (CODIGO)
);

/*==============================================================*/
/* Table: PRODUTO                                               */
/*==============================================================*/
DROP TABLE PRODUTO CASCADE CONSTRAINT;

create table PRODUTO  (
   CODIGO               INTEGER                         not null,
   DESCRICAO            varchar2(80)                    not null,
   UNID_MEDIDA          varchar2(10)                    not null,
   constraint PK_PRODUTO primary key (CODIGO)
);

-- *******************************************************
-- COMENTÁRIOS DIVERSOS E DEMONSTRAÇÕES DE COMANDO SELECT, CREATE E ALTER TABLE
/*
-- CRIANDO E ELIMINANDO A TABELA FONE_VENDEDOR
CREATE TABLE FONE_VENDEDOR
(
 NUMERO        VARCHAR2(14),
 MATRICULA_VEN INTEGER,
 CONSTRAINT PK_FONE_VENDEDOR PRIMARY KEY (NUMERO,MATRICULA_VEN)
);

DROP TABLE FONE_VENDEDOR;

-- ALTERANDO A TABELA FONE_VENDEDOR PARA REFERENCIAR A TABELA VENDEDOR
ALTER TABLE FONE_VENDEDOR
ADD CONSTRAINT FK_FONE_VENDEDOR FOREIGN KEY (MATRICULA_VEN) REFERENCES VENDEDOR (MATRICULA);

-- CRIANDO A TABELA SEM A PK 
DROP TABLE VENDEDOR CASCADE CONSTRAINTS;

CREATE TABLE VENDEDOR 
(
 MATRICULA            INTEGER,
 CNPF                 VARCHAR2(12),
 NOME                 VARCHAR2(60)
);

-- CRIANDO A TABELA COM A PK COM O PRÓPRIO SISTEMA ATRIBUINDO SEU NOME
CREATE TABLE VENDEDOR 
(
 MATRICULA            INTEGER PRIMARY KEY,
 CNPF                 VARCHAR2(12),
 NOME                 VARCHAR2(60)
);

-- CRIANDO A TABELA COM A PK, DANDO NOME PARA A MESMA
CREATE TABLE VENDEDOR 
(
 MATRICULA            INTEGER NOT NULL CONSTRAINT PK_VENDEDOR PRIMARY KEY,
 CNPF                 VARCHAR2(12),
 NOME                 VARCHAR2(60)
);

-- CRIANDO A TABELA COM A PK COMPOSTA
CREATE TABLE VENDEDOR 
(
 MATRICULA            INTEGER NOT NULL ,
 CNPF                 VARCHAR2(12),
 NOME                 VARCHAR2(60),
 CONSTRAINT PK_VENDEDOR PRIMARY KEY (MATRICULA,CNPF)
);

-- ALTERANDO DEFINIÇÕES DA TABELA VENDEDOR
-- INCLUINDO A PK
ALTER TABLE VENDEDOR
ADD CONSTRAINT PK_VENDEDOR PRIMARY KEY (MATRICULA);

-- EXCLUIR A PK
ALTER TABLE VENDEDOR
DROP CONSTRAINT PK_VENDEDOR;

-- ACRESCENTANDO UMA REGRA PARA NÃO PERMITIR NULO NA COLUNA MATRICULA
ALTER TABLE VENDEDOR
ADD CONSTRAINT CK_NOT_NULL_MATRICULA CHECK (MATRICULA IS NOT NULL);

ALTER TABLE VENDEDOR
DROP CONSTRAINT CK_NOT_NULL_MATRICULA;

-- TENTANDO INSERIR UMA REGISTRO NA TABELA VENDEDOR
INSERT INTO VENDEDOR VALUES (1,'111111111-11','YY');

-- DELETANDO TODOS OS DADOS DA TABELA VENDEDOR
DELETE FROM VENDEDOR;

-- DESFAZENDO UMA TRANSAÇÃO COMPLETA
ROLLBACK;

SELECT *
FROM VENDEDOR;

-- ACRESCENTANDO UMA REGRA PARA NÃO PERMITIR NULO NA COLUNA MATRICULA OUTRA MANEIRA
ALTER TABLE VENDEDOR
MODIFY MATRICULA NUMBER(20) NOT NULL;

-- ACRESCENTANDO UMA REGRA PARA NÃO PERMITIR NULO NA COLUNA MATRICULA OUTRA MANEIRA
ALTER TABLE VENDEDOR
ADD X NUMBER(20);

-- ELIMINANDO A TABELA VENDEDOR
DROP TABLE VENDEDOR;

-- ALTERAR O NOME DA TABELA VENDEDOR PARA VENDEDOR1
ALTER TABLE VENDEDOR RENAME TO VENDEDOR1;

-- ALTERAR O NOME DA COLUNA X PARA Y NA TABELA VENDEDOR1
ALTER TABLE VENDEDOR1 RENAME COLUMN X TO Y;

-- VERIFICAR A ESTRUTURA DA TABELA CRIADA
DESC VENDEDOR1;
DESC FONE_VENDEDOR;
-- MOSTRANDO AS TABELAS DO SEU USUÁRIO NO DD, RESTRINGINDO À DE VENDEDOR
SELECT *
FROM USER_TABLES
WHERE TABLE_NAME IN ('VENDEDOR','FONE_VENDEDOR');

-- MOSTRA AS REGRAS BÁSICAS (CONSTRAINTS) DA TABELA VENDEDOR
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('VENDEDOR','FONE_VENDEDOR');

DESC USER_CONSTRAINTS;

-- MOSTRA A REGRA COM AS COLUNA(S) QUE FAZEM PARTE DA MESMA NA TABELA VENDEDOR
SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME IN ('VENDEDOR','FONE_VENDEDOR');

-- COMENTÁRIOS GERAIS SOBRE SELECT - CRIANDO COLUNAS (RELAÇÕES CONSTANTES) COM CÁLCULOS DIVERSOS
-- A PARTIR DE UMA TABELA VIRTUAL CHAMADA DUAL.
SELECT (2 + 2) * 10 AS CALCULO1,
       (12/55) AS CALCULO2,
       ROUND((12/55),2) AS CALCULO3,
       TRUNC((12/55),2) AS CALCULO4,
       TO_CHAR(SYSDATE,'DD-MM-YYYY') "DATA SISTEMA"
FROM DUAL;

SELECT *
FROM (SELECT (2 + 2) * 10 AS CALCULO1
       FROM DUAL)
      UNION 
     (SELECT (12/55) AS CALCULO2
       FROM DUAL)
ORDER BY 1 DESC;

-- SELECIONANDO TODOS OS OBJETOS DE BANCO QUE SEU USUÁRIO PODE VER
SELECT OBJECT_NAME,
       OBJECT_TYPE
FROM ALL_OBJECTS;

SELECT OBJECT_NAME,
       OBJECT_TYPE
FROM ALL_OBJECTS
WHERE OBJECT_NAME LIKE 'U%CONS%';

-- CONTANDO A QUANTIDADE DE LINHAS EXISTENTES EM ALL_OBJECTS QUE SEU USUARIO PODE VER
SELECT COUNT(*)
FROM ALL_OBJECTS;

-- SELECIONANDO OS TIPOS DE OBJETOS DISTINTOS NO BANCO DE DADOS
SELECT DISTINCT OBJECT_TYPE
FROM ALL_OBJECTS;

-- CONTANDO A QUANTIDADE DE TIPOS DE OBJETOS DISTINTOS NA VIEW ALL_OBJECTS
SELECT COUNT(DISTINCT OBJECT_TYPE)
FROM ALL_OBJECTS;

SELECT COUNT( OBJECT_TYPE)
FROM ALL_OBJECTS
WHERE LOWER(OBJECT_TYPE)='view';

-- UTILIZANDO O OPERADOR LIKE COM OS METACARACTERES % E _
SELECT  OBJECT_NAME
FROM ALL_OBJECTS
WHERE LOWER(OBJECT_NAME) LIKE '__b%ie%';

-- MOSTRANDO A ESTRUTURA DA VIEW ALL_OBJECTS
DESC ALL_OBJECTS;

-- MOSTRANDO TODAS AS CONSTRAINTS (REGRAS DE BANCO) DOS OBJETOS DO USUÁRIO LOGADO.
SELECT *
FROM USER_CONSTRAINTS;
*/
--    b. Criar as tabelas associativas: PEDIDO, ESTOQUE, CAPACIDADE_ESTOQUE E ITEM_PRODUTO.  
--       Não incluir na criação dessas tabelas as chaves primária (PK) e estrangeiras (FK). 
-- SOLUÇÃO:
/*==============================================================*/
/* Table: PEDIDO                                                */
/*==============================================================*/
DROP TABLE PEDIDO CASCADE CONSTRAINT;

create table PEDIDO  (
   NUMERO               NUMBER(6)                       not null,
   DATA                 DATE                            not null,
   PRAZO_ENTREGA        DATE,
   RUA                  varchar2(80),
   NR                   NUMBER(4),
   BAIRRO               varchar2(50),
   COMPLEMENTO          varchar2(100),
   CIDADE               varchar2(50),
   UF                   varchar2(2),
   CEP                  varchar2(10),
   TOTAL_FATURA         NUMBER(8,2),
   CODIGO_CLI           INTEGER                         not null,
   MATRICULA_VEN        INTEGER                         not null
);

/*==============================================================*/
/* Table: ITEM_PRODUTO                                          */
/*==============================================================*/
DROP TABLE ITEM_PRODUTO;

create table ITEM_PRODUTO  (
   CODIGO_PRO           INTEGER                         not null,
   NUMERO_PED           NUMBER(6)                       not null,
   QUANTIDADE           NUMBER(5)                       not null,
   PRECO_UNITARIO       NUMBER(5,2)                     not null,
   VALOR_ITEM           NUMBER(7,2)
);

/*==============================================================*/
/* Table: CAPACIDADE_ESTOQUE                                    */
/*==============================================================*/
DROP TABLE CAPACIDADE_ESTOQUE;

create table CAPACIDADE_ESTOQUE  (
   CODIGO_PRO           INTEGER                         not null,
   CODIGO_PRA           NUMBER(3)                       not null,
   QUANTIDADE           NUMBER(5)                       not null
);

/*==============================================================*/
/* Table: ESTOQUE                                               */
/*==============================================================*/
DROP TABLE ESTOQUE;

create table ESTOQUE  (
   DATA_ENTRADA         DATE                            not null,
   CODIGO_PRO           INTEGER                         not null,
   CODIGO_PRA           NUMBER(3)                       not null,
   QUANTIDADE           NUMBER(5)                       not null,
   DATA_VALIDADE        DATE
);

--    c. Criar as constraints de chave primaria (primary key) para as tabelas associativas.
-- RESOLUÇÃO:
alter table PEDIDO
ADD   constraint PK_PEDIDO primary key (NUMERO);

alter table ITEM_PRODUTO
ADD   constraint PK_ITEM_PRODUTO primary key (CODIGO_PRO, NUMERO_PED);

alter table CAPACIDADE_ESTOQUE
ADD   constraint PK_CAPACIDADE_ESTOQUE primary key (CODIGO_PRO, CODIGO_PRA);

alter table ESTOQUE
ADD   constraint PK_ESTOQUE primary key (CODIGO_PRO, CODIGO_PRA, DATA_ENTRADA);

--    d. Criar as constraints das chaves estrangeiras (foreing key) para as tabelas associativas.
-- RESOLUÇÃO:
alter table PEDIDO
   add constraint FK_PED_VENDEDOR foreign key (MATRICULA_VEN)
      references VENDEDOR (MATRICULA);

alter table PEDIDO
   add constraint FK_PED_CLIENTE foreign key (CODIGO_CLI)
      references CLIENTE (CODIGO);

alter table ITEM_PRODUTO
   add constraint FK_ITEM_PEDIDO foreign key (NUMERO_PED)
      references PEDIDO (NUMERO);

alter table ITEM_PRODUTO
   add constraint FK_ITEM_PRODUTO foreign key (CODIGO_PRO)
      references PRODUTO (CODIGO);

alter table CAPACIDADE_ESTOQUE
   add constraint FK_CAP_EST_PRATELEIRA foreign key (CODIGO_PRA)
      references PRATELEIRA (CODIGO);

alter table CAPACIDADE_ESTOQUE
   add constraint FK_CAP_EST_PRODUTO foreign key (CODIGO_PRO)
      references PRODUTO (CODIGO);

alter table ESTOQUE
   add constraint FK_EST_PRATELEIRA foreign key (CODIGO_PRA)
      references PRATELEIRA (CODIGO);

alter table ESTOQUE
   add constraint FK_EST_PRODUTO foreign key (CODIGO_PRO)
      references PRODUTO (CODIGO);

--    e. Criar uma constraint que garanta que o valor do NUMERO da tabela PEDIDO esteja entre, inclusive, 
--       1 e 99999.
-- RESOLUÇÃO:
alter table PEDIDO
   add constraint CK_NUMERO_PEDIDO check (NUMERO BETWEEN 1 AND 99999);
   
--    f. Juntar as tabelas FONE_CLIENTE e FONE_VENDEDOR em uma única tabela, relacionando-a com CLIENTE e  
--       VENDEDOR. Criar as regras de integridade básica necessárias para garantir a qualidade
--       dos dados. A nova tabela se chamará FONE, com as colunas CODIGO_CLI, MATRICULA_VEN, NUMERO.
--       Quando a coluna CODIGO_CLI estivel preenchida a MATRICULA_VEN estará vazia e vice-versa.
-- RESOLUÇÃO:
CREATE TABLE FONE
AS
SELECT NUMERO,
       CODIGO_CLI,
       NULL AS MATRICULA_VEN
FROM FONE_CLIENTE
UNION
SELECT NUMERO,
       NULL AS CODIGO_CLI,
       MATRICULA_VEN
FROM FONE_VENDEDOR
;

-- SOLUÇÃO CONSIDERANDO QUE O MESMO TELEFONE PODE PERTENCER TANTO A CLIENTE QUANTO VENDEDOR
CREATE TABLE FONE
AS
SELECT NVL(A.NUMERO,B.NUMERO) AS NUMERO,
       A.CODIGO_CLI,
       B.MATRICULA_VEN
FROM (
      SELECT NUMERO,
             CODIGO_CLI
      FROM FONE_CLIENTE
      ) A FULL JOIN
      (SELECT NUMERO,
             MATRICULA_VEN
      FROM FONE_VENDEDOR
      ) B ON A.NUMERO=B.NUMERO;
      
/*-- COMENTÁRIOS E DICAS
CREATE TABLE PRAT
AS
SELECT *
FROM DEMO.PRATELEIRA;

-- JUNTANDO O CONTEUDO DE DEMO.PRATELEIRA COM PRAT
CREATE TABLE P1
AS
SELECT CODIGO AS DEMO,
       NULL AS PRAT,
       DESCRICAO,
       NUMERO_SECOES
FROM DEMO.PRATELEIRA
UNION
SELECT NULL AS COD_PRAT,
       CODIGO AS PRAT,
       DESCRICAO,
       NUMERO_SECOES
FROM PRAT;

DESC PRAT;
DESC P1;

SELECT *
FROM P1;

SELECT * 
FROM ALL_TABLES 
WHERE TABLE_NAME='P1';

DROP TABLE P1;
*/
--    g. Criar os indexes das tabelas PF e PJ. Estes indexes serão únicos e utilizados 
--       como listas invertidas.
-- RESOLUÇÃO:
CREATE UNIQUE INDEX IND_CNPF_PF
ON PF (CNPF DESC);

CREATE UNIQUE INDEX IND_CNPF_PJ
ON PJ (CNPJ DESC);

/*-- COMENTÁRIOS GERAIS
DROP INDEX TESTE_I;

CREATE UNIQUE INDEX TESTE_I
ON VENDEDOR (CNPF DESC);

SELECT *
FROM ALL_OBJECTS
WHERE OBJECT_NAME LIKE 'U%IND%';

SELECT *
FROM USER_INDEXES
WHERE TABLE_NAME = 'VENDEDOR';

SELECT *
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'VENDEDOR';
*/
--    h. Criar comentários para a tabela ITEM_PRODUTO e suas respectivas colunas.
-- RESOLUÇÃO:
comment on table ITEM_PRODUTO is
'Mantém os dados dos itens de produtos dos pedidos no negócio do sistema de pedido.';

comment on column ITEM_PRODUTO.CODIGO_PRO is
'Código que identifica cada produto do negócio. PEx: 12345.';

comment on column ITEM_PRODUTO.NUMERO_PED is
'Número que identifica cada pedido efetuado no sistema. Seu valor é sequencial e é gerado por uma sequence de nome SEQ_NUNMERO_PEDIDO. PEx: 123456.';

/*-- COMENTÁRIOS GERAIS
COMMENT ON TABLE PRODUTO IS 'mANTÉM OS DADOS DOS PRODUTOS.';
COMMENT ON COLUMN PRODUTO.CODIGO IS 'CCCXXXXXVVVVV.'; 

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME='PRODUTO';

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='PRODUTO';

SELECT *
FROM ALL_COL_COMMENTS
WHERE TABLE_NAME='PRODUTO';

SELECT *
FROM ALL_OBJECTS
WHERE OBJECT_NAME LIKE 'U%COMM%';
*/
--    i. Criar uma sequence de nome SEQ_ITEM_ID para o campo CODIGO de ITEM_PRODUTO, com
--       incremento de 2.
-- RESOLUÇÃO:
CREATE SEQUENCE SEQ_ITEM_ID INCREMENT BY 2;

-- COMENTÁRIOS GERAIS
DROP SEQUENCE SEQ1 ;

CREATE SEQUENCE SEQ1 MINVALUE 10 MAXVALUE 21 INCREMENT BY 3 CYCLE CACHE 2;

SELECT SEQ1.NEXTVAL
FROM DUAL;

SELECT SEQ1.CURRVAL
FROM DUAL;

SELECT *
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME='SEQ1';
--********************************************************************************
-- QUESTÃO 2) Inserir os seguintes dados nas tebela criadas:
--    a. Copiar os dados do projeto pedido cujo o owner seja o DEMO. Todas as tabelas 
--       do usuário DEMO estão compartilhadas para leitura, exceto ITEM_PEDIDO.
-- RESOLUÇÃO:
-- Inclusão de CLIENTES
INSERT INTO CLIENTE
SELECT *
FROM DEMO.CLIENTE;

DESC CLIENTE;

-- Inclusão de FONE_CLIENTE
INSERT INTO FONE_CLIENTE
SELECT *
FROM DEMO.FONE_CLIENTE;

-- Inclusão de VENDEDOR
INSERT INTO VENDEDOR
SELECT *
FROM DEMO.VENDEDOR;

-- Inclusão de FONE_VENDEDOR
INSERT INTO FONE_VENDEDOR
SELECT *
FROM DEMO.FONE_VENDEDOR;

-- Inclusão de PF
INSERT INTO PF
SELECT *
FROM DEMO.PF;

-- Inclusão de PJ
INSERT INTO PJ
SELECT *
FROM DEMO.PJ;

-- Inclusão de PEDIDO
INSERT INTO PEDIDO
SELECT *
FROM DEMO.PEDIDO;

-- Inclusão de PRATELEIRA
INSERT INTO PRATELEIRA
SELECT *
FROM DEMO.PRATELEIRA;

-- Inclusão de PRODUTO
INSERT INTO PRODUTO
SELECT *
FROM DEMO.PRODUTO;

-- Inclusão de CAPACIDADE_ESTOQUE
INSERT INTO CAPACIDADE_ESTOQUE
SELECT *
FROM DEMO.CAPACIDADE_ESTOQUE;

-- Inclusão de ESTOQUE
INSERT INTO ESTOQUE
SELECT *
FROM DEMO.ESTOQUE;

COMMIT;
/*
-- COMENTÁRIOS GERAIS SOBRE INSERÇÕES
-- INSERINDO LINHA-A-LINHA OU REGISTRO POR REGISTRO
INSERT INTO PRODUTO  VALUES (1,'PRODUTO1','U');
INSERT INTO PRODUTO (DESCRICAO,UNID_MEDIDA,CODIGO) VALUES (3,'PRODUTO1',3);
INSERT INTO PRODUTO VALUES (4,'PRODUTO1',3,NULL);

-- INSERINDO MULTIPLAS LINHAS OU REGISTROS
INSERT INTO PRODUTO (DESCRICAO,CODIGO,UNID_MEDIDA,TESTE)
SELECT UNID_MEDIDA,
       SEQ_ITEM_ID.NEXTVAL,
       SUBSTR(DESCRICAO,3,9),
       CODIGO
FROM DEMO.PRODUTO;

DESC PRODUTO;

SELECT SEQ_ITEM_ID.NEXTVAL
FROM DUAL;

SELECT *
FROM PRODUTO
ORDER BY TESTE DESC, 3 ASC,CODIGO ASC;

SELECT *
FROM DEMO.PRODUTO;

ALTER TABLE PRODUTO
ADD TESTE VARCHAR2(10);

ALTER TABLE PRODUTO
DROP COLUMN TESTE;

ROLLBACK;

DELETE FROM PRODUTO;
*/
--    b. A tabela ITEM_PRODUTO receberá os seguintes dados:

--    1. Produto 207 para todos os pedidos pares e ano menor 2018, com a quantidade 100 e 
--       preço unitário R$ 10.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO 
SELECT 207 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       100 AS QUANTIDADE,
       10.00 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE MOD(NUMERO,2)=0
  AND TO_CHAR(DATA, 'YYYY') < 2018;

/*  
-- COMENTÁRIOS GERAIS
INSERT INTO ITEM_PRODUTO 
SELECT 207 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       100 AS QUANTIDADE,
       10.00 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE MOD(NUMERO,2)=0
  AND EXTRACT(YEAR FROM TO_DATE(DATA, 'DD-MM-YYYY')) < 18;
  
SELECT EXTRACT(YEAR FROM TO_DATE(DATA, 'DD-MM-YYYY'))
FROM PEDIDO;

SELECT TO_CHAR(DATA, 'YYYY')
FROM PEDIDO
WHERE TO_CHAR(DATA, 'YYYY') < 2018;

SELECT *
FROM ITEM_PRODUTO;
*/
--    2. Produto 206 para todos os pedidos impares e ano igual 2018, com a quantidade 50 e
--       preço unitário R$ 12.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO 
SELECT 206 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       50 AS QUANTIDADE,
       12.00 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE MOD(NUMERO,2)=1
  AND TO_CHAR(DATA, 'YYYY') = 2018;

--    3. Produto 207 para todos os pedidos pares e ano igual 2018, com a quantidade 150 e
--       preço unitário R$ 14.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO 
SELECT 207 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       150 AS QUANTIDADE,
       14.00 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE MOD(NUMERO,2)=0
  AND TO_CHAR(DATA, 'YYYY') = 2018;

--    4. Produto 206 para todos os pedidos impares e ano menor 2018, com a quantidade 200 e
--       preço unitário R$ 8.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO 
SELECT 206 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       200 AS QUANTIDADE,
       8.00 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE MOD(NUMERO,2)=1
  AND TO_CHAR(DATA, 'YYYY') < 2018;

--    5. Produto 208 para todos sem endereço de entrega e ano igual 2017, com a quantidade 80 e
--       preço unitário R$ 18.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO 
SELECT 208 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       80 AS QUANTIDADE,
       18.00 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE TO_CHAR(DATA, 'YYYY') = 2017
  AND RUA IS NULL;

--    6. Produto 208 para todos sem endereço de entrega e ano igual 2018, com a quantidade 70 e
--       preço unitário R$ 20.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO 
SELECT 208 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       70 AS QUANTIDADE,
       20.00 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE TO_CHAR(DATA, 'YYYY') = 2018
  AND PRAZO_ENTREGA IS NULL;
  
--    7. Produto 202 para todos pedidos com endereço de entrega e dia impar de entrega, com a 
--       quantidade 60 e preço unitário R$ 15.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO 
SELECT 202 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       60 AS QUANTIDADE,
       15.00 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE MOD(TO_NUMBER(TO_CHAR(PRAZO_ENTREGA, 'DD')),2) = 1
  AND RUA IS NOT NULL;
 
--    8. Produto 205 para todos pedidos com endereço de entrega e dia par da data do pedido, com a 
--       quantidade 90 e preço unitário R$ 11.50
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO 
SELECT 205 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       90 AS QUANTIDADE,
       11.50 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE MOD(TO_NUMBER(TO_CHAR(DATA, 'DD')),2) = 0
  AND RUA IS NOT NULL;
  
--    9. Produto 203 para todos pedidos com endereço de entrega e dia ímpar da data de pedido, com a
--       quantidade 550 e preço unitário R$ 21.35
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO 
SELECT 203 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       550 AS QUANTIDADE,
       21.35 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE MOD(TO_NUMBER(TO_CHAR(DATA, 'DD')),2) = 1
  AND RUA IS NOT NULL;
  
--    10. Produto 204 para todos pedidos sem endereço de entrega e dia par da data do pedido, com a
--       quantidade 150 e preço unitário R$ 25.85
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO 
SELECT 204 AS CODIGO_PRO,
       NUMERO AS  NUMERO_PED,
       150 AS QUANTIDADE,
       25.85 AS PRECO_UNITARIO,
       NULL
FROM PEDIDO
WHERE MOD(TO_NUMBER(TO_CHAR(DATA, 'DD')),2) = 0
  AND RUA IS NULL;

COMMIT;

--*********************************************************************************
-- QUESTÃO 3) Alterar os seguintes dados na tebela ITEM_PRODUTO:
--    a. Para os produtos com CODIGO menor 20 e maior que 50, com 
--       produtos de 203 a 205, inclusive: Multiplicar a QUANTIDADE por 2
-- RESOLUÇÃO:
UPDATE ITEM_PRODUTO SET QUANTIDADE=QUANTIDADE * 2
WHERE  CODIGO_PRO BETWEEN 203 AND 205;

/*-- COMENTÁRIOS GERAIS
SELECT *
FROM IP_TESTE;

UPDATE IP_TESTE SET VALOR_ITEM=QUANTIDADE * PRECO_UNITARIO;

-- ALTERAR A QUANTIDADE PARA 50% DOS PEDIDOS ENTRE 20 E 30, INCLUSIVE 
UPDATE IP_TESTE SET QUANTIDADE= TRUNC(QUANTIDADE/2,0)
WHERE NUMERO_PED BETWEEN 20 AND 30;

SELECT *
FROM IP_TESTE
WHERE NUMERO_PED BETWEEN 20 AND 30;
-- CRIANDO UMA TABELA PARA DEMOSTRAÇÃO DO UPDATE
CREATE TABLE IP_TESTE
AS
SELECT *
FROM ITEM_PRODUTO;

SELECT *
FROM ALUNO.IP_TESTE;

-- LIBERANDO A VISUALIZAÇÃO PARA PÚBLICO
GRANT SELECT ON IP_TESTE TO PUBLIC;
*/
--    b. Para o cliente CODIGO ímpar com vendedor de MATRICULA par: somar 15 na QUANTIDADE.
-- RESOLUÇÃO:
UPDATE ITEM_PRODUTO SET QUANTIDADE=QUANTIDADE + 15
WHERE  NUMERO_PED IN (SELECT  NUMERO 
                  FROM PEDIDO 
                  WHERE MOD(MATRICULA_VEN,2)=0 
                    AND MOD(CODIGO_CLI,2)=1
                );

--    c. Para pedidos com NUMERO multiplo de 3: Retirar R$ 0.50 no valor de cada preço unitário. 
-- RESOLUÇÃO:
UPDATE ITEM_PRODUTO SET PRECO_UNITARIO=PRECO_UNITARIO - 0.50
WHERE  MOD(NUMERO_PED,3)=0;
  
--    d. Ajustar os valores de todos os itens, em conformidade com a quantidade e 
--       preço unitário de cada produto.
-- RESOLUÇÃO:
UPDATE ITEM_PRODUTO SET VALOR_ITEM=QUANTIDADE * PRECO_UNITARIO;

--    e. Ajustar o total da fatura de todos os pedidos, em conformidade com os valores 
--       dos itens incluídos em cada pedido.
-- RESOLUÇÃO:
UPDATE PEDIDO P SET TOTAL_FATURA= (SELECT SUM(VALOR_ITEM)
                                  FROM ITEM_PRODUTO
                                  WHERE NUMERO_PED=P.NUMERO);

COMMIT;

--*********************************************************************************
-- QUESTÃO 4) Deletar os seguintes dados:
--    a. Excluir os registros de PEDIDO em que o número seja ímpar, matricula do vendedor 102, 
--       e o endereço de entrega não seja nulo. 
--       Observação: Realizar a exclusão e verificar que os registros foram excluídos apenas na transação.
-- RESOLUÇÃO:
-- EXCLUINDO OS ITENS DEPENDENTES DA TABELA ITEM_PRODUTO DOS PEDIDOS CORRESPONDENTES
DELETE FROM ITEM_PRODUTO
WHERE NUMERO_PED IN ( SELECT NUMERO
                      FROM PEDIDO
                      WHERE MOD(NUMERO,2)=1
                        AND MATRICULA_VEN=102
                        AND RUA IS NOT NULL
                    );

-- EXCLUINDO OS PEDIDOS CORRESPONDENTES
DELETE FROM PEDIDO
WHERE MOD(NUMERO,2)=1
  AND MATRICULA_VEN=102
  AND RUA IS NOT NULL;
  
-- VERIFICANDO OS VALORES QUE SERÃO EXCLUÍDOS NO BANCO DE DADOS
-- DA TABELA PEDIDO
SELECT *
FROM PEDIDO
WHERE MOD(NUMERO,2)=1
  AND MATRICULA_VEN=102
  AND RUA IS NOT NULL;
  
-- DA TABELA ITEM_PRODUTO
SELECT *
FROM ITEM_PRODUTO
WHERE NUMERO_PED IN ( SELECT NUMERO
                      FROM PEDIDO
                      WHERE MOD(NUMERO,2)=1
                        AND MATRICULA_VEN=102
                        AND RUA IS NOT NULL
                    );
  
--    b. Excluir os itens de produtos do menor número de pedido na última data de inclusão de   
--       pedido.
--       Observação: Realizar a exclusão e verificar que os registros foram excluídos apenas na transação.
-- RESOLUÇÃO:
DELETE FROM ITEM_PRODUTO
WHERE NUMERO_PED IN (
                      SELECT MIN(NUMERO)
                      FROM PEDIDO
                      WHERE DATA = (
                                    SELECT MAX(DATA)
                                    FROM PEDIDO
                                    )
                    );

-- VERIFICANDO OS VALORES QUE SERÃO EXCLUÍDOS NO BANCO DE DADOS
SELECT *
FROM  ITEM_PRODUTO
WHERE NUMERO_PED IN (
                      SELECT MIN(NUMERO)
                      FROM PEDIDO
                      WHERE DATA = (
                                    SELECT MAX(DATA)
                                    FROM PEDIDO
                                    )
                    );
                    
--    c. Desfazer as exclusões dos itens a. e b. da questão 4) acima.
--       Observação: Verificar que os registros estão nas respectivas tabelas.
-- RESOLUÇÃO:
ROLLBACK;

/*-- COMENTÁRIOS SOBRE FUNÇÕES DE GRUPO (MIN, MAX, AVG, COUNT, SUM)
SELECT MATRICULA_VEN,
       TO_CHAR(DATA,'MM-YYYY') AS MES_ANO,
       MIN(DATA),
       MAX(DATA),
       SUM(NUMERO) AS TOTAL_VENDA,
       COUNT(*),
       TRUNC(AVG(MATRICULA_VEN + CODIGO_CLI),2)
FROM PEDIDO
WHERE MATRICULA_VEN != 100 -- <> EQUIVALENTE AO !=
GROUP BY MATRICULA_VEN,
         TO_CHAR(DATA,'MM-YYYY')
HAVING SUM(NUMERO) >= 8
ORDER BY 1,2;
*/
--*********************************************************************************
-- QUESTÃO 5) Selecionar OU criar views dos seguintes dados extraídos nas tebelas criadas:
--    a. Selecionar as constraints criadas da tabela ITEM_PRODUTO
-- RESOLUÇÃO:
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='ITEM_PRODUTO';

--    b. Selecionar os comentários da tabela ITEM_PRODUTO e suas respectivas colunas, com apenas uma query
--       mostranto o TIPO (tabela ou coluna), NOME (descrição da tabela ou coluna) e COMENTÁRIO
-- RESOLUÇÃO:
SELECT 'TABELA' AS TIPO,
       TABLE_NAME AS NOME,
       COMMENTS AS COMENTARIO
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME='ITEM_PRODUTO'
UNION
SELECT 'COLUNA' AS TIPO,
       COLUMN_NAME AS NOME,
       COMMENTS AS COMENTARIO
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='ITEM_PRODUTO'
ORDER BY TIPO DESC, NOME ASC;

SELECT *
FROM ALL_OBJECTS
WHERE OBJECT_NAME LIKE '%COM%';

--    c. Criar a view de clientes constante do BD Pedidos (VIEW_CLIENTE) contendo os dados das tabelas CLIENTE,
--       PF e PJ.
-- RESOLUÇÃO:
CREATE OR REPLACE VIEW VIEW_CLIENTE
AS
SELECT CASE
         WHEN CNPF IS NULL THEN 'PJ' 
         ELSE 'PF'
       END AS TIPO,
       CLIENTE.*,
       PF.CNPF,
       PF.RG,
       PF.DATA_NASCIMENTO,
       PJ.CNPJ,
       PJ.IE,
       PJ.NOME_FANTASIA
FROM PJ RIGHT JOIN
     CLIENTE ON CLIENTE.CODIGO=PJ.CODIGO_CLI LEFT JOIN
     PF ON CLIENTE.CODIGO=PF.CODIGO_CLI;

SELECT *
FROM VIEW_CLIENTE;

--    d. Selecionar todos os clientes da view VIEW_CLIENTE que são PF, ordenado decrescente
--       pelo nome do cliente.
-- RESOLUÇÃO:
SELECT *
FROM VIEW_CLIENTE
WHERE TIPO = 'PF'
ORDER BY NOME DESC;

--    e. Listar os pedidos e seus respectivos produtos.
--       Mostrar: NUMERO (como Pedido), DATA, DESCRICAO (como Produto) e QUANTIDADE.
--                ordenado pela DATA do pedido crescente e pelo produto decrescente.
-- RESOLUÇÃO:
SELECT P.NUMERO AS Pedido,
       P.DATA, 
       PR.DESCRICAO AS Produto,
       IP.QUANTIDADE
FROM PEDIDO P JOIN
     ITEM_PRODUTO IP ON P.NUMERO=IP.NUMERO_PED JOIN
     PRODUTO PR ON IP. CODIGO_PRO=PR.CODIGO
ORDER BY 2,3 DESC;
     
--    f. Listar o vendedor com a maior e o com a menor totalização de pedidos realizados.
--       Mostrar: MATRICULA, NOME, MAIOR_TOTAL, MENOR_TOTAL
--       Ordenado decrescente pela matricula.
-- RESOLUÇÃO:
SELECT MATRICULA,
       NOME,
       NULL AS MENOR_TOTAL,
       TOTAL AS MAIOR_TOTAL
FROM (SELECT V.MATRICULA,
             V.NOME,
             SUM(P.TOTAL_FATURA) TOTAL
      FROM PEDIDO P JOIN
           VENDEDOR V ON P.MATRICULA_VEN=V.MATRICULA
      GROUP BY V.MATRICULA,
               V.NOME
     ) A 
WHERE TOTAL = (SELECT MAX(TOTAL)
               FROM (
                     SELECT SUM(TOTAL_FATURA) TOTAL
                      FROM PEDIDO 
                      GROUP BY MATRICULA_VEN
                    )
              )
UNION
SELECT MATRICULA,
       NOME,
       TOTAL AS MENOR_TOTAL,
       NULL AS MAIOR_TOTAL
FROM (SELECT V.MATRICULA,
             V.NOME,
             SUM(P.TOTAL_FATURA) TOTAL
      FROM PEDIDO P JOIN
           VENDEDOR V ON P.MATRICULA_VEN=V.MATRICULA
      GROUP BY V.MATRICULA,
               V.NOME
     ) A 
WHERE TOTAL = (SELECT MIN(TOTAL)
               FROM (
                     SELECT SUM(TOTAL_FATURA) TOTAL
                      FROM PEDIDO 
                      GROUP BY MATRICULA_VEN
                    )
               ); 

--    g. Obter o produto(CODIGO e DESCRICAO) mais pedidos nos últimos 2 anos.
--       Ordenado crescente pela descrição.
-- RESOLUÇÃO:
SELECT CODIGO,
       DESCRICAO
FROM ITEM_PRODUTO JOIN
     PRODUTO ON CODIGO_PRO=CODIGO JOIN
     PEDIDO ON NUMERO_PED=NUMERO
WHERE TO_CHAR(DATA,'YYYY') >= TO_CHAR(SYSDATE,'YYYY') - 2
GROUP BY CODIGO,
         DESCRICAO
HAVING SUM(QUANTIDADE) = ( SELECT MAX(QDE)
                            FROM (
                                  SELECT SUM(QUANTIDADE) AS QDE
                                  FROM ITEM_PRODUTO
                                  GROUP BY CODIGO_PRO
                                 )   
                          )
ORDER BY DESCRICAO;

--    h. Obter o produto(CODIGO e DESCRICAO) distintos pedidos no último ano de pedido.
--       realizado. Ordenado decrescente pelo código
-- RESOLUÇÃO:
SELECT DISTINCT CODIGO,
       DESCRICAO
FROM ITEM_PRODUTO JOIN
     PRODUTO ON CODIGO_PRO=CODIGO JOIN
     PEDIDO ON NUMERO_PED=NUMERO
WHERE TO_CHAR(DATA,'YYYY') = (SELECT MAX(TO_CHAR(DATA,'YYYY'))
                              FROM PEDIDO
                              )
ORDER BY CODIGO DESC;

--    j. Listar a maior diferença entre os preços unitários dos produtos pedidos.
-- RESOLUÇÃO:
SELECT MAX(PRECO_UNITARIO) - MIN(PRECO_UNITARIO) AS MAIOR_DIFERENCA
FROM ITEM_PRODUTO;

--    l. Criar a view que mostra a capacidade de estoque constante do BD Pedidos 
--       (VIEW_CAPACIDADE_ESTOQUE) contendo os dados correspondentes ao modelo
--       apresentado.
CREATE OR REPLACE VIEW VIEW_CAPACIDADE_ESTOQUE 
AS
SELECT PRO.DESCRICAO AS PRODUTO,
       PRA.DESCRICAO AS PRATELEIRA,
       CE.QUANTIDADE,
       PRO.UNID_MEDIDA AS UNIDADE_MEDIDA
FROM   PRODUTO PRO JOIN
       CAPACIDADE_ESTOQUE CE ON (PRO.CODIGO=CE.CODIGO_PRO) JOIN
       PRATELEIRA PRA ON (CE.CODIGO_PRA=PRA.CODIGO);

--    m. Listar os produtos não pedidos nos últimos 90 dias.
--      Mostrar: CODIGO e DESCRICAO
--      ordenados por descrição decrescente
-- RESOLUÇÃO:
SELECT CODIGO,
       DESCRICAO
FROM PRODUTO 
WHERE CODIGO NOT IN (SELECT CODIGO_PRO
                      FROM ITEM_PRODUTO JOIN
                           PEDIDO ON NUMERO_PED=NUMERO 
                      WHERE DATA >= SYSDATE - 90
                    );
 
--    n. Listar as prateleiras e os respectivos produtos que podem armazenar.
--       Mostrando a frase 'sem produto' quando não se relaciona com nenhum.
--      Mostrar: Prateleira (CODIGO, DESCRICAO), descrição (PRODUTO) 
--      e quantidade distinta de produtos.
--      ordenados pela quantidade de produtos decrescente.
-- RESOLUÇÃO:
SELECT P.CODIGO,
       P.DESCRICAO,
       NVL(PRO.DESCRICAO,'SEM PRODUTO') AS PRODUTO,
       CE.QUANTIDADE
FROM PRATELEIRA P LEFT JOIN
     CAPACIDADE_ESTOQUE CE ON P.CODIGO=CE.CODIGO_PRA LEFT JOIN
     PRODUTO PRO ON PRO.CODIGO=CE.CODIGO_PRO;

-- A questão ficou mal formulada. Todas as prateleiras possui previsão de produtos.
-- Para verificar o resultado com SEM PRODUTO,incluir a prateleira abaixo:
     INSERT INTO PRATELEIRA VALUES (390,'Prateleira de teste',2);
     
--    o. Criar a view que mostra estoque constante no BD Pedidos. 
--       (VIEW_ESTOQUE) contendo os dados indicados no modelo apresentado.


