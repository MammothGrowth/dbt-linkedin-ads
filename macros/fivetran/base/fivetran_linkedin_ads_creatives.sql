{% macro fivetran_linkedin_ads_creatives() %}

    {{ adapter_macro('linkedin_ads.fivetran_linkedin_ads_creatives') }}

{% endmacro %}


{% macro default__fivetran_linkedin_ads_creatives() %}

with aggregated as(
    select 

        id as creative_id,
        campaign_id,
        status,
        type,
        text_ad_text as ad_text,
        text_ad_title as ad_title,
        headline,
        click_uri as url,
        last_modified_time,
        _fivetran_synced
    from {{source('linkedin_ads', 'CREATIVE_HISTORY')}}
),ranked as (

    select
    
        *,
        rank() over (partition by creative_id
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