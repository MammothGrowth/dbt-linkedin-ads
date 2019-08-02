{% macro fivetran_linkedin_ads_accounts() %}

    {{ adapter_macro('linkedin_ads.fivetran_linkedin_ads_accounts') }}

{% endmacro %}


{% macro default__fivetran_linkedin_ads_accounts() %}

with aggregated as(

select 

    id as account_id,
    name as account_name,
    status,
    type,
    currency currency_type,
    reference,
    last_modified_time,
    _fivetran_synced
from {{source('linkedin_ads', 'ACCOUNT_HISTORY')}}
    
),ranked as (

    select
        *,
        rank() over (partition by account_id
            order by _fivetran_synced desc) as latest
            
    from aggregated
),
final as (

    select *
    from ranked
    where latest = 1

)
select * from final


{% endmacro %}