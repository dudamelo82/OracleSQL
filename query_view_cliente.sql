
create or replace view VIEW_CLIENTE

as

select (select 'Pessoa fisica' from pf where pf.codigo_cli = c.codigo) as TIPO ,
        c.codigo,
        c.nome, 
        (select pf.cnpf from pf where pf.codigo_cli = c.codigo) as CNPF,
        (select null from pj where pj.codigo_cli = c.codigo) as CNPJ
from cliente c inner join
pf on c.codigo = pf.codigo_cli

union 

select (select 'Pessoa juridica' from pj where pj.codigo_cli = c.codigo) as TIPO ,
        c.codigo, 
        c.nome, 
        (select null as cnpf from pf where pf.codigo_cli = c.codigo) as CNPF,
        (select  pj.cnpj from pj where pj.codigo_cli = c.codigo) as CNPJ
from cliente c inner join
pj on c.codigo = pj.codigo_cli;


desc view_cliente;

select * from user_views;