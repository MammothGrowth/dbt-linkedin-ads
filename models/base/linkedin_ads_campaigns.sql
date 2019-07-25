{% if var('etl') == 'fivetran' %}

    {{ fivetran_linkedin_ads_campaigns() }}
    
{% endif %}