WITH transactions_transitions_log as (

    SELECT * 
    FROM {{ref("transaction_transitions_seed")}}

)

SELECT * from transactions_transitions_log



