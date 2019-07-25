{% macro fivetran_linkedin_ads_campaigns() %}

    {{ adapter_macro('linkedin_ads.fivetran_linkedin_ads_campaigns') }}

{% endmacro %}


{% macro default__fivetran_linkedin_ads_campaigns() %}

with aggregated as(

    select distinct

        id as campaign_id,
        campaign_group_id,
        name,
        status,
        type as campaign_type,
        objective,
        optimization_target_type,
        creative_selection,
        locale_country,
        daily_budget_amount budget,
        _fivetran_synced

    from {{var('campaigns_table')}}

),ranked as (

    select
    
        *,
        rank() over (partition by campaign_id
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