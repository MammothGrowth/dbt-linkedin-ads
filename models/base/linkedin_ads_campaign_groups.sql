{% if var('etl') == 'fivetran' %}

    {{ fivetran_linkedin_ads_ad_groups() }}
    
{% endif %}