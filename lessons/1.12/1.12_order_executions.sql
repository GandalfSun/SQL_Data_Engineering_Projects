select
    cd.name as company_name,
    count(jpf.*) as postings_count
from job_postings_fact as jpf
left join company_dim as cd
    on jpf.company_id = cd.company_id
where jpf.job_country = 'United States'
group by cd.name
having count(jpf.*) > 3000
order by postings_count desc
limit 10;
