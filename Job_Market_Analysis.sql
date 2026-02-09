create database job_market;
use job_market;


select count(*) from job_postings_fact;
select count(*) from skills_dim;
select count(*) from skills_job_dim;

#Identify high paying remote data analyst roles.
#What are the top-paying remote data analyst jobs so we can benchmarking salaries ?
#select * from job_postings_fact;

select job_id, job_title, job_location, salary_year_avg
from job_postings_fact
where salary_year_avg is not null
and job_title_short = 'Data Analyst'
and job_work_from_home = 'True'
order by salary_year_avg desc
limit 10;


#Shows salary ceiling
#Helps recruiters set competitive compensation
#Helps candidates negotiate confidently
# I filtered high-quality salary data and ranked top remote roles to identify market benchmarks.



#Demand Analysis : What skills are employers asking for ?
#Business Question : Which skills appear most frequently in data analyst job postings ?

select s.skills,
count(sj.job_id) as demand_count
from job_postings_fact j
join skills_job_dim sj on j.job_id = sj.job_id
join skills_dim s on sj.skill_id = s.skill_id
where j.job_title_short = 'Data Analyst'
group by s.skills
order by demand_count desc
limit 10;

#Bussiness Insight : SQL, EXCEL, PYTHON dominate demand.


#Bussiness Problem : Which skills pays the most ?
#Business Question : Which technical skills are associated with higher salaries ?

select s.skills,
round(avg(j.salary_year_avg),0) as avg_salary
from job_postings_fact j
join skills_job_dim sj on j.job_id = sj.job_id
join skills_dim s on sj.skill_id = s.skill_id
where j.salary_year_avg is not null
and j.job_title_short = 'Data Analyst'
group by s.skills 
order by avg_salary desc
limit 10;

#Insignts:
#Python, sql, Bi tools, cloud skills push salaries up.
#Shows skills monetization value.


#Business Problem : Skill ROI : High demand + high salary
#Question : Which skills learners prioritize for faster carees growth ?

with demand as (
select s.skills, s.skill_id,
 count(*) as demand_count
 from job_postings_fact j
 join skills_job_dim sj 
 on j.job_id = sj.job_id
 join skills_dim s
 on sj.skill_id = s.skill_id
 where j.job_title_short = 'Data Analyst'
 Group by s.skill_id, s.skills
 ),
 salary as
 (
 select s.skill_id,
 round(avg(j.salary_year_avg), 0) avg_salary
 from job_postings_fact j
 join skills_job_dim sj 
 on j.job_id = sj.job_id
 join skills_dim s 
 on sj.skill_id = s.skill_id
 where j.salary_year_avg is not null
 group by s.skill_id
 )
 select d.skills, d.demand_count, s.avg_salary,
 round(d.demand_count * s.avg_salary / 1000, 0) as opportunity_score
 from demand d
 join salary s 
 on d.skill_id = s.skill_id
 order by opportunity_score desc
 limit 10;


#Business Problem : Remote VS onsite Salary comparision.

select job_work_from_home,
round(avg(salary_year_avg),0) as avg_salary
from job_postings_fact
where salary_year_avg is not null
group by job_work_from_home;

#Insight : Determines if remote jobs pay competitively.


#Rank top - paying data analysis.

select job_id,
job_title,
salary_year_avg,
rank() over(order by salary_year_avg desc) as salary_rank
from job_postings_fact
where job_title_short = 'Data Analyst'
and job_work_from_home = 'True'
and salary_year_avg is not null ;


#Skills appearing in at least 50 jobs.
select 
s.skills,
count(*) as demand_count
from skills_job_dim sj
join skills_dim s 
on sj.skill_id = s.skill_id
group by s.skills
having count(*) >= 50
order by demand_count desc ;


#Top 3 skills per salary bucket.

WITH salary_bands AS (
    SELECT
        job_id,
        CASE
            WHEN salary_year_avg < 70000 THEN 'Low'
            WHEN salary_year_avg BETWEEN 70000 AND 100000 THEN 'Medium'
            ELSE 'High'
        END AS salary_band
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
),
skill_counts AS (
    SELECT
        sb.salary_band,
        s.skills,
        COUNT(*) AS skill_count
    FROM salary_bands sb
    JOIN skills_job_dim sj ON sb.job_id = sj.job_id
    JOIN skills_dim s ON sj.skill_id = s.skill_id
    GROUP BY sb.salary_band, s.skills
)
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY salary_band
               ORDER BY skill_count DESC
           ) AS rnk
    FROM skill_counts
) ranked
WHERE rnk <= 3;


#Business Question : Find jobs without salary data but requiring high-paying skills (Python, SQL, BI)

SELECT DISTINCT
j.job_id, j.job_title
FROM job_postings_fact j
JOIN skills_job_dim sj ON j.job_id = sj.job_id
JOIN skills_dim s ON sj.skill_id = s.skill_id
WHERE j.salary_year_avg IS NULL
AND s.skills IN ('SQL', 'Python', 'Power BI', 'Tableau');

#Pareto analysis.
WITH skill_demand AS (
SELECT
s.skills,
COUNT(*) AS demand
FROM skills_job_dim sj
JOIN skills_dim s ON sj.skill_id = s.skill_id
GROUP BY s.skills
),
running_total AS (
SELECT
skills,
demand,
SUM(demand) OVER (ORDER BY demand DESC) AS cumulative_demand,
SUM(demand) OVER () AS total_demand
FROM skill_demand
)
SELECT
skills,
demand
FROM running_total
WHERE cumulative_demand <= 0.8 * total_demand;


