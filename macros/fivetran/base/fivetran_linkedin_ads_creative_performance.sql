{% macro fivetran_linkedin_ads_creative_performance() %}

    {{ adapter_macro('linkedin_ads.fivetran_linkedin_ads_creative_performance') }}

{% endmacro %}

{% macro default__fivetran_linkedin_ads_creative_performance() %}

with source1 as (

    select * 
    from {{source('linkedin_ads', 'AD_ANALYTICS_BY_CREATIVE')}}
    
),

campaign_groups1 as (

    select * from {{ref('linkedin_ads_campaign_groups')}}
    
),

campaigns1 as (

    select * from {{ref('linkedin_ads_campaigns')}}
    
),

creatives1 as (

    select * from {{ref('linkedin_ads_creatives')}}
    
),

rollup1 as (

    select
        {{dbt_utils.surrogate_key(
            'day', 
            'creative_id')}} 
        as creative_performance_report_id,
        day as campaign_date,
        creative_id,
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(cost_in_local_currency) as spend
    from source1 as source
    {{dbt_utils.group_by(3)}}
    
),

joined as (

    select
        rollup.*,
        campaign_groups.name as campaign_group_name,
        campaigns.campaign_id,
        campaigns.name as campaign_name,
        campaigns.status as campaign_status,
        campaign_groups.account_id,
        campaign_groups.campaign_group_id,
        replace(coalesce(creatives.url, ''),'%20', ' ') as url
    from rollup1 as rollup
    left join creatives1 as creatives using (creative_id)
    left join campaigns1 as campaigns ON creatives.campaign_id = campaigns.campaign_id
    left join campaign_groups1 as campaign_groups ON campaign_groups.campaign_group_id = campaigns.campaign_group_id
        
),

final as (

    select
        *,
        {{ dbt_utils.get_url_host('url') }} as url_host,
        '/' || {{ dbt_utils.get_url_path('url') }} as url_path,
        {{ dbt_utils.get_url_parameter('url', 'utm_source') }} as utm_source,
        {{ dbt_utils.get_url_parameter('url', 'utm_medium') }} as utm_medium,
        {{ dbt_utils.get_url_parameter('url', 'utm_campaign') }} as utm_campaign,
        {{ dbt_utils.get_url_parameter('url', 'utm_content') }} as utm_content,
        {{ dbt_utils.get_url_parameter('url', 'utm_term') }} as utm_term
    from joined
    
)

select * from final

{% endmacro %}