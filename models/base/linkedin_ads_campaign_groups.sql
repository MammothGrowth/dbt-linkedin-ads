{% if var('etl') == 'fivetran' %}

    {{ fivetran_linkedin_ads_campaign_groups() }}
    
{% endif %}