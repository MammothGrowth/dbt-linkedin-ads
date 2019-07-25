with linkedin_ads_creative_performance as (

    select * from {{ref('linkedin_ads_creative_performance')}}

),

linkedin_ads_creative_performance_agg as (

    select 
    
        campaign_date,
        creative_id as creative_id,
        campaign_group_id,
        campaign_group_name,
        url_host,
        url_path,
        utm_source,
        utm_medium,
        utm_campaign,
        utm_content,
        utm_term,
        campaign_id,
        campaign_name,
        'linkedin ads' as platform,
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(spend) as spend
        
    from linkedin_ads_creative_performance
    {{ dbt_utils.group_by(14) }}

)

select * from linkedin_ads_creative_performance_agg