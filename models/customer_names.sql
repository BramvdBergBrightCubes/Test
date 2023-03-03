{% macro get_first_names() %}
{{ return(["Michael", "Harry", "Laura"]) }}
{% endmacro %}

{% set required_names = get_first_names() %}
{% set first_order_date = "2018-01-01" %}
{% set last_order_date = "2018-01-31" %}

{% if first_order_date is string %}
{% endif %}

with
    customers as (select * from {{ ref("stg_customers") }}),

    orders as (select * from {{ ref("stg_orders") }}),




{% if required_names is defined and required_names|length > 0 %}
    {% for required_name in required_names %}
        {{required_name}}_view as (
            select *
            from customers, orders
            where
                (customers.first_name = "{{required_name}}")
                and (orders.order_date between "{{first_order_date}}" and "{{last_order_date}}")
        )
        {% if not loop.last %}
        ,
        {% endif %}
    {% endfor %}
{% endif %}

select * from Michael_view
