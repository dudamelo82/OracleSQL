--*********************************************************************************
-- 2) Deletar os seguintes dados:
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

--****************************************************************************
