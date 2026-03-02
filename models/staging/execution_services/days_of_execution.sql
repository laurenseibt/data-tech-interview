WITH transition_times AS (
    SELECT
        transaction_id,
        MIN(CASE WHEN new_state = 'bid_accepted' THEN transitioned_at END) AS bid_accepted_at,
        MIN(CASE WHEN new_state = 'closed_paid' THEN transitioned_at END) AS closed_paid_at
    FROM {{ref("transactions_transitions_log")}}
    WHERE new_state IN ('bid_accepted', 'closed_paid')
    GROUP BY transaction_id
)

SELECT
    tt.transaction_id,
    tt.bid_accepted_at,
    tt.closed_paid_at,
    DATEDIFF(day, tt.bid_accepted_at, tt.closed_paid_at) AS days_of_execution,
    d.state as current_state,
    d.company_id,
    d.num_shares,
    d.price_per_share,
    d.gross_proceeds

FROM transition_times tt
LEFT JOIN {{ref("transactions_details")}} d ON tt. transaction_id = d.id
WHERE tt.closed_paid_at IS NOT NULL
  AND tt.bid_accepted_at IS NOT NULL
  AND d._fivetran_deleted = false
