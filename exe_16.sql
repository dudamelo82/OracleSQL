

SELECT C.CLIENTE AS Cliente
       WHERE TIPO = 'PJ',
       P.NUMERO AS Pedido, 
       PR.DESCRICAO AS Produto,
FROM PEDIDO P JOIN
     ITEM_PRODUTO IP ON P.NUMERO=IP.NUMERO_PED JOIN
     PRODUTO PR ON IP. CODIGO_PRO=PR.CODIGO
ORDER BY NOME DESC, NUMERO, Pedido;