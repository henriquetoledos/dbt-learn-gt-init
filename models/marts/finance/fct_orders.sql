WITH orders as (

    SELECT * FROM  {{ref('stg_jaffle_shop__orders')}}

),

payments as (
    SELECT * FROM {{ref('stg_stripe__payments')}} 
),

order_payments as (
    select
        order_id,
        payment_date,
        sum (case when payment_status = 'success' then amount_usd end) as amount_usd

    from payments
    group by 1,2
),

final as (
    SELECT
        orders.order_id,
        orders.customer_id,

        -- dates
        orders.order_date,
        order_payments.payment_date,

        -- amounts
        order_payments.amount_usd,

        -- additional information
        orders.order_status

    FROM orders
    LEFT JOIN order_payments USING (order_id) 

)

SELECT 
    *
FROM final
