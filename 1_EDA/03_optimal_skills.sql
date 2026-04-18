select
    sd.skills,
    round(median(jpd.salary_year_avg), 0) as median_salary,
    count(jpd.*) as demand_count,
    round(ln(count(jpd.*)), 1) as ln_demand_count,
    round((median(jpd.salary_year_avg) * ln(count(jpd.*)))/1_000_000, 2) as optimal_score
from job_postings_fact as jpd
inner join skills_job_dim as sjd
    on jpd.job_id = sjd.job_id
inner join skills_dim as sd
   on sjd.skill_id = sd.skill_id
where
    jpd.job_title_short = 'Data Engineer'
    and jpd.job_work_from_home = true
    and jpd.salary_year_avg is not null
group by 
    sd.skills
having
    count(jpd.*) > 100
order by 
    optimal_score desc
limit 25;    
/*          
┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │          193 │             5.3 │          0.98 │
│ python     │      135000.0 │         1133 │             7.0 │          0.95 │
│ aws        │      137320.3 │          783 │             6.7 │          0.92 │
│ sql        │      130000.0 │         1128 │             7.0 │          0.91 │
│ airflow    │      150000.0 │          386 │             6.0 │           0.9 │
│ spark      │      140000.0 │          503 │             6.2 │          0.87 │
│ kafka      │      145000.0 │          292 │             5.7 │          0.83 │
│ snowflake  │      135500.0 │          438 │             6.1 │          0.83 │
│ azure      │      128000.0 │          475 │             6.2 │          0.79 │
│ java       │      135000.0 │          303 │             5.7 │          0.77 │
│ scala      │      137290.5 │          247 │             5.5 │          0.76 │
│ kubernetes │      150500.0 │          147 │             5.0 │          0.75 │
│ databricks │      132750.0 │          266 │             5.6 │          0.74 │
│ git        │      140000.0 │          208 │             5.3 │          0.74 │
│ redshift   │      130000.0 │          274 │             5.6 │          0.73 │
│ gcp        │      136000.0 │          196 │             5.3 │          0.72 │
│ hadoop     │      135000.0 │          198 │             5.3 │          0.72 │
│ nosql      │      134415.0 │          193 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │          152 │             5.0 │           0.7 │
│ docker     │      135000.0 │          144 │             5.0 │          0.68 │
│ mongodb    │      135750.0 │          136 │             4.9 │          0.67 │
│ r          │      134775.0 │          133 │             4.9 │          0.66 │
│ go         │      140000.0 │          113 │             4.7 │          0.66 │
│ github     │      135000.0 │          127 │             4.8 │          0.65 │
│ bigquery   │      135000.0 │          123 │             4.8 │          0.65 │
├────────────┴───────────────┴──────────────┴─────────────────┴───────────────┤
│ 25 rows                                                           5 columns │
└─────────────────────────────────────────────────────────────────────────────┘

*/