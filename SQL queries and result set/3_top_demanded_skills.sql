/*
Question: What are the most in demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in demand skills for a Data Analyst
- Focus on all job postings
- Why? Retrieves the top 5 skills with the highest demand in the
  job market, providing insights into the most valuable skills for
  job seekers.
*/

SELECT
  skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM
  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_title_short = 'Data Analyst'
  AND job_location LIKE '%Tampa,_FL%'
GROUP BY
  skills
ORDER BY
  demand_count DESC
LIMIT 5

/*

Here's the breakdown of how many job postings require these in demand skills 
for Data Analysts in Tampa, FL area in 2023 based on job postings:

- SQL is leading with a count of 668
- Excel is trailing SQL with a count of 534
- Python, Tableau, and R come in last with a count of 366, 338, and 293 
  respectively

- RESULT SET OF QUERY IN JSON FORMAT - 

[
  {
    "skills": "sql",
    "demand_count": "668"
  },
  {
    "skills": "excel",
    "demand_count": "534"
  },
  {
    "skills": "python",
    "demand_count": "366"
  },
  {
    "skills": "tableau",
    "demand_count": "338"
  },
  {
    "skills": "r",
    "demand_count": "293"
  }
]

*/