WITH transactions_details as (
   SELECT *
   FROM {{ref("transactions_seed")}}
)


SELECT * from transactions_details