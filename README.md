# Maven Analytics - Advanced SQL Course using Snowflake
A repo for those who take [Maven Analytics - Advanced SQL: MySQL Data Analysis & Business Intelligence](https://www.udemy.com/course/advanced-sql-mysql-for-analytics-business-intelligence/) and want to use Snowflake rather than using MySQL as their primary database.

1. First you need to upload attached .csv files into an s3 bucket.
2. Your snowflake account must have access privileges to that s3 bucket. In this example, Snowflake's storage integration option is used. For further details, see [this](https://docs.snowflake.com/en/user-guide/data-load-s3-config.html).
3. You must update all *<s3_bucket_name>* and *<IAM_role_ARN>* fields in create_mavenfuzzyfactory.sql file with the correct information.
4. You can copy all the content of the create_mavenfuzzyfactory.sql file to a Snowflake worksheet and execute all of the commands.
