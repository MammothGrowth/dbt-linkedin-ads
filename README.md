# linkedin ads

This package models Linkedin Ads data.

[Here](https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads-reporting/ads-reporting) is info
from Microsoft's Linkedin Ads API overview.

[Here](https://fivetran.com/docs/applications/linkedin-ads) 
is info about Fivetran's Linkedin Ads connector.

[Here](https://docs.getdbt.com/docs/package-management) is some additional 
information about packages in dbt. If you haven't already, you will need to create
a `packages.yml` file in your project and supply the git link from this repository.

You should then copy the linkedin_ads package structure from the `dbt_project.yml` in
this repository into your project's `dbt_project.yml` file and replace the `#`
values with the linkedin ads table names from your warehouse. You will also need to 
select which ETL tool you use (stitch or fivetran) in the `etl` var.