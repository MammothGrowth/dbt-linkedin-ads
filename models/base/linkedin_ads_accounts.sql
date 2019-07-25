{% if var('etl') == 'fivetran' %}

    {{ fivetran_linkedin_ads_accounts() }}
    
{% endif %}