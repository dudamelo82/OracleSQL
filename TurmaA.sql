-- select fdsdfdsdfsd
/*
select


from
*/
-- obteção de valores constantes com apelidos para as colunas
select round(((1234 + 432)/789),3) as "calculo 1",
       trunc(1234 + 432/789,2) calculo2,
       to_char(sysdate,'day-mon-year') data_hoje
from dual;

-- obtenção de constantes para cada linha recuperada de uma tabela
select trunc(1234 + 432/789,2) as col1,
       emp.*
from emp;

-- 
select *
from demo.s_emp; -- tabela que possui o sinônimo emp

-- A view que mostra todos os objetos de banco que sua conta pode visualizar
-- contagem da quantidade de objetos com a função de grupo count
select count(*)
from all_objects;

-- restringindo as ocorrências existentes na all_object
select lower(owner),
       object_name,
       object_type
from all_objects
where lower(object_name) like 'tab%';

-- restringindo as ocorrências existentes na all_object acrescentando
-- uma coluna constante
select 'Empresa' as CONSTANTE,
       lower(owner),
       object_name,
       object_type
from all_objects
where lower(object_name) like 'tab%';

-- restringindo as ocorrências existentes na all_object acrescentando
-- uma coluna constante e instanciando em uma tabela de nome teste
drop table teste;

create table teste
as
select 'Empresa' as CONSTANTE,
       lower(owner) as owner,
       object_name,
       object_type
from all_objects
where lower(object_name) like 'tab%';

-- restringindo as ocorrências existentes na all_object com nome iniciando com tes
select lower(owner),
       object_name,
       object_type
from all_objects
where lower(object_name) like 'tes%';

-- restringindo as ocorrências existentes na all_object 
-- sugerindo as views que mostrem colunas de tabelas
select owner,
       object_name,
       object_type
from all_objects
where object_name like '____A__L%';

-- DESCOBRINDO AS COLUNAS DA TABELA TESTE
DESC USER_TAB_COLS;

SELECT *
FROM USER_TAB_COLS
WHERE TABLE_NAME = 'TESTE';


SELECT *
FROM USER_TABLES;

-- mostrar a estrutura uma tabela ou view (comando describe)
DESC ALL_OBJECTS;
desc teste;

-- verificando o conteudo do teste
select *
from teste;

-- criando a tabela t2 - exercitando várias possibilidades 
-- de inclusões de regras básicas
DROP TABLE T2;

create table t2
(
 col1  number CONSTRAINT PK_T2 PRIMARY KEY,
 col2  number(5,2),
 CONSTRAINT CK_COL11 CHECK (COL1 > 0)
);

-- INSERINDO VALORES NA TABELA CRIADA
INSERT INTO T2 (COL1,COL2) VALUES (NULL,2.02);

-- alterando valores da tabela t2
update t2 set col3='teste';

SELECT *
FROM T2;

-- ALTERANDO A TABELA T2 - acrescentando uma coluna
alter table t2
add col3 varchar2(100);

alter table t2
modify col3 not null;
-- alterando a tabela t2, eliminando e recriando constraints

alter table t2
drop constraint SYS_C00123664;

alter table t2
drop constraint PK_T2;

alter table t2
drop constraint CK_COL11;

-- reincluindo as regras eliminadas
alter table t2
add constraint PK_T2 primary key (col1);

alter table t2
add constraint CK_COL11 check (col1 > 0);

-- criando uma tabela t3 e relacionando a mesma com t2, 
-- por intermédio da col1
create table t3
(
 col4     number CONSTRAINT PK_T3 PRIMARY KEY,
 col1_t2  number
);

-- alterando a tabela t3, criando a constraint de chave estrangeira
alter table t3
add constraint fk_t3_t2 foreign key (col1_t2) references t2 (col1); 

alter table t3
add constraint ck_col1_t2_nnulo check (col1_t2 is not null);

alter table t3
add constraint uk_col1_t2 unique (col1_t2);

-- inserindo valores na t3
desc t3;

select *
from t2;

insert into t3 values (1,2); -- não permitiu porque não tinha o valor 2 em t2
insert into t3 values (1,1);
insert into t3 values (2,null);
insert into t3 (col1_t2,col4) values (1,3); -- equivalente a linha abaixo
insert into t3  values (3,1);

select *
from t3;

desc t2;

-- inserindo valores na tabela t2
insert into t2 (col1,col2,col3) values (2,null,'Coluna 3');
insert into t2 (col1,col3) values (3,'Coluna 3 repetido');
insert into t2 values (4,'','Coluna 3 duplicada');

-- inserindo vários registros em um comando de inserção
insert into t2
select seq_t2_col1.nextval as col1,
       col2,
       col3
from t2;

select *
from t2;
-- desfazer o resultado das operações da transação aberta
rollback;

-- verificando se a tabel existe no BD
desc t2;

-- Criando e entendendo indeces
drop index ind_t2_col1;
create index ind_t2_col1 on t2(col1,col2 desc);

-- verificando os indices no BD
select *
from user_indexes
where table_name='T2';

select *
from user_ind_columns
where table_name='T2'
order by 1,column_position desc;

-- trabalhando com comentários de tabelas e colunas
comment on table t2 is 'Comentários relacionados à tabela T2.';
comment on column t2.col1 is 'Comentários da coluna COL1 da tabela T2.';

-- verificando o comentário no DD
select *
from user_tab_comments
where table_name='T2';

select *
from user_col_comments
where table_name='T2';

-- Criando, entendendo e utilizando sequences
drop sequence seq_t2_col1;
create sequence seq_t2_col1 minvalue 1 cycle maxvalue 40 cache 5 start with 20 increment by 5;
create sequence seq_t2_col1 start with 6;
-- verificando as sequences no DD
select *
from user_sequences
where sequence_name='SEQ_T2_COL1';

-- manipulando uma sequence
select seq_t2_col1.nextval
from dual;

select seq_t2_col1.currval
from dual;
--
SELECT *
FROM USER_TABLES
where table_name='T2';

SELECT *
FROM USER_TAB_COLS
WHERE TABLE_NAME = 'T2';

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME in ('T2','T3');

SELECT *
FROM USER_CONS_columns
WHERE TABLE_NAME in ('T2','T3');

-- Alterações de banco de dados (DML - Update)
desc t2;
select *
from t2;

update t2 set col3='Testando....' where mod(col1,3)=0;

update t2 T set col3=(select to_char(col2)
                     from t2
                     where col1=t.col1);

rollback;

-- Deleções de registros de banco de dados (DML - Delete)
delete from t3;
truncate table t3;

select *
from t3;

desc t3;

delete from t2 
where col3='teste' or mod(col1,2)=1;

select *
from t2
where col3='teste' or mod(col1,2)=1;

-- Inserções de registros na tabela T3
insert into t3
select seq_t2_col1.nextval as col1,
       col1
from t2
where col1 <> 1;

commit;

-- Comentarios sobre as funções de grupo
select codigo_cli,
       --data,
       min(data),
       max(data),
       sum(codigo_cli),
       avg(codigo_cli) as media,
       count(*)
from pedido
--where codigo_cli=10;
group by codigo_cli,data
--having sum(codigo_cli) > 50
order by count(*),4 asc;

select *
from pedido;

-- Comentários sobre views
-- Discutindo junções entre tabelas
create or replace view pvcf
as
select p.numero,
       p.data,
       p.matricula_ven,
       vendedor.matricula,
       vendedor.nome as vendedor,
       c.*,
       pf.*,
       'xxxx' constante
from pedido p inner join
     vendedor on p.matricula_ven = vendedor.matricula join
     (select *
      from cliente) c on p.codigo_cli = c.codigo join
     pf on c.codigo = pf.codigo_cli;

desc pvcf;

-- verificando as views existentes no BD
select *
from user_views;


"select p.numero,
       p.data,
       p.matricula_ven,
       vendedor.matricula,
       vendedor.nome as vendedor,
       c.*,
       pf.*,
       'xxxx' constante
from pedido p inner join
     vendedor on p.matricula_ven = vendedor.matricula join
     cliente c on p.codigo_cli = c.codigo join
     pf on c.codigo = pf.codigo_cli"
     
-- operador union
select 'Cliente' as origem,
       cliente.nome as nome,
       numero as fone
from fone_cliente join
     cliente on fone_cliente.codigo_cli=cliente.codigo
union
select 'Vendedor',
       vendedor.nome,
       f.numero
from fone_vendedor f join
     vendedor on f.MATRICULA_VEN=vendedor.MATRICULA;
     
     
-- solução da view_cliente (ver modelo de dados de pedido)
create or replace view view_cliente
as
select 'PF' as tipo,
       c.codigo,
       c.nome,
       pf.cnpf,
       null as cnpj
from cliente c join
     pf on c.codigo=pf.codigo_cli
UNION     
select 'PJ' as tipo,
       c.codigo,
       c.nome,
       null cnpf,
       pj.cnpj as cnpj
from cliente c join
     pj on c.codigo=pj.codigo_cli
order by tipo,codigo;

select *
from view_cliente;

-- solução da view VIEW_CAPACIDADE_ESTOQUE (ver modelo de dados de pedido)
create or replace view VIEW_CAPACIDADE_ESTOQUE
as
select p.descricao as produto,
       pra.descricao as prateleira,
       ce.quantidade,
       p.unid_medida
from produto p join
     capacidade_estoque ce on p.codigo=ce.codigo_pro join
     prateleira pra on ce.codigo_pra=pra.codigo
order by 1, 2 desc;

select *
from VIEW_CAPACIDADE_ESTOQUE;

-- solução da view VIEW_ESTOQUE (ver modelo de dados de pedido)
create or replace view VIEW_ESTOQUE
as
select produto.descricao as produto,
       ent.total_ent as quantidade_adquirida,
       sai.total_sai as quantidade_saida,
       ent.total_ent - sai.total_sai as disponivel,
       produto.unid_medida
from (
      select codigo_pro,
             sum(quantidade) total_ent
      from estoque
      group by codigo_pro
     ) ent join
     (
      select codigo_pro,
             sum(quantidade) total_sai
      from item_produto
      group by codigo_pro
     ) sai on ent.codigo_pro=sai.codigo_pro join
     produto on ent.codigo_pro=produto.codigo
order by produto asc;

select *
from VIEW_ESTOQUE;

-- Solução do exercício de DML - 1ª Select

select pe.numero as pedido,
       pe.data,
       pr.descricao as produto,
       ip.quantidade
from produto pr join
     item_produto ip on pr.codigo=ip.codigo_pro join
     pedido pe on ip.numero_ped=pe.numero
order by data asc,
         produto desc;
         
-- Solução do exercício de DML - 2ª Select

select distinct pr.codigo,
       pr.descricao
from produto pr join
     item_produto ip on pr.codigo=ip.codigo_pro join
     pedido pe on ip.numero_ped=pe.numero
where to_char(pe.data,'yyyy')= (
                              select max(to_char(data,'yyyy'))
                              from pedido
                            );
                            
-- Solução do exercício de DML - 3ª Select
select produto.codigo,
       produto.descricao
from produto left join
     (select *
      from pedido join
           item_produto ip on pedido.numero = ip.numero_ped
      where data >= (sysdate - 680)
     ) A on A.codigo_pro = produto.codigo
where a.numero is null
order by produto.descricao desc;


