create or replace view VIEW_CAPACIDADE_ESTOQUE

as

select  produto.DESCRICAO as PRODUTO,
        prateleira.CODIGO as PRATELEIRA,
        quantidade as QUANTIDADE, 
        produto.UNID_MEDIDA  as UNIDADE_MEDIDA
        from estoque inner join
produto on estoque.codigo_pro = produto.codigo  join
prateleira on prateleira.CODIGO = estoque.CODIGO_PRA;




--desc VIEW_CAPACIDADE_ESTOQUE;

--select * from user_views; 