with customers as (

    select * from {{ ref('customers') }}

),

natality as (

    select * from {{ ref('stg_natality') }}

),

new_data as (

    select
        Year,

        County,
        Births,

    from natality

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join natality using (Year)

)

select * from final