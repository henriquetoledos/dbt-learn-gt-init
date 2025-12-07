select 
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status as payment_status,

    -- amount is stored in cents, convert it to dollars
    amount/100 as amount_usd,

    created as payment_date
from raw.stripe.payment
