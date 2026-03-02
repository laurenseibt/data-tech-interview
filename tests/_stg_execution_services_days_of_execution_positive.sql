Select 
    transaction_id,
    days_of_execution
    FROM {{ref('days_of_execution')}}
    WHERE days_of_execution < 0