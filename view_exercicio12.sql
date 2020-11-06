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