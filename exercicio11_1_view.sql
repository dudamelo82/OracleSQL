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