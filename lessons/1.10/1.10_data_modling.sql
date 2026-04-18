select *
from skills_dim
limit 5;

select *
from information_schema.tables
where table_catalog = 'data_jobs';