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
/*==============================================================*/
/* Table: FONE                                                  */
/*==============================================================*/
DROP TABLE FONE CASCADE CONSTRAINT;

create table FONE  (
   CODIGO               INTEGER                         not null,
   NUMERO               varchar2(14)                    not null,
   CODIGO_CLI           INTEGER                         not null,
   MATRICULA_VEN        INTEGER                         not null,
   constraint PK_FONE primary key (CODIGO),
   constraint FK_FONE_CLI foreign key (CODIGO_CLI) references CLIENTE (CODIGO),
   constraint FK_FONE_VEN foreign key (MATRICULA_VEN) references VENDEDOR (MATRICULA),
   constraint UK_FONE unique key (NUMERO,CODIGO_CLI,MATRICULA_VEN)
);
     
--    g. Criar os indexes das tabelas PF e PJ. Estes indexes serão únicos e utilizados 
--       como listas invertidas.
-- RESOLUÇÃO:
CREATE UNIQUE INDEX IND_CNPF_PF
ON PF (CNPF DESC);

CREATE UNIQUE INDEX IND_CNPF_PJ
ON PJ (CNPJ DESC);

--    h. Criar comentários para a tabela ITEM_PRODUTO e suas respectivas colunas.
-- RESOLUÇÃO:
comment on table ITEM_PRODUTO is
'Mantém os dados dos itens de produtos dos pedidos no negócio do sistema de pedido.';

comment on column ITEM_PRODUTO.CODIGO_PRO is
'Código que identifica cada produto do negócio. PEx: 12345.';

comment on column ITEM_PRODUTO.NUMERO_PED is
'Número que identifica cada pedido efetuado no sistema. Seu valor é sequencial e é gerado por uma sequence de nome SEQ_NUNMERO_PEDIDO. PEx: 123456.';

--    i. Criar uma sequence de nome SEQ_ITEM_ID para o campo CODIGO de ITEM_PRODUTO, com
--       incremento de 2.
-- RESOLUÇÃO:
create sequence  SEQ_ITEM_ID increment by 2;

