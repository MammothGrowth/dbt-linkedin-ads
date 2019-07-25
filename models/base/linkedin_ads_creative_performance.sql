{% if var('etl') == 'fivetran' %}

    {{ fivetran_linkedin_ads_creative_performance() }}
    
{% endif %}