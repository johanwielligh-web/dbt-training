payments as (

    select 
        order_id,
        sum(amount) as lifetime_value
    from {{ ref('stg_stripe_payments') }}

),

orders as (

    select 
        *
    from {{ ref('stg_orders') }}

),



final as (

    select
        orders.customer_id,
        orders.order_id,
        payments.lifetime_value

    from orders

    left join payments using (order_id)

)

select * from final