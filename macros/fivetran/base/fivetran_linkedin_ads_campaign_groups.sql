{% macro fivetran_linkedin_ads_campaign_groups() %}

    {{ adapter_macro('linkedin_ads.fivetran_linkedin_ads_campaign_groups') }}

{% endmacro %}


{% macro default__fivetran_linkedin_ads_campaign_groups() %}

with aggregated as(

select

    id as campaign_group_id,
    account_id,
    run_schedule_start start_date,
    run_schedule_end end_date,
    status,
    name,
    _fivetran_synced
from {{source('linkedin_ads', 'CAMPAIGN_GROUP_HISTORY')}}

),ranked as (

    select
    
        *,
        rank() over (partition by campaign_group_id
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