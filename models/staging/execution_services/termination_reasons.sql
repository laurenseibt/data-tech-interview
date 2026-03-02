WITH termination_reasons as (
   SELECT *
   FROM {{ref("transaction_termination_reasons_seed")}}
)


SELECT * from termination_reasons