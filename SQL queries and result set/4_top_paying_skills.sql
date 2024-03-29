/*

Question: What are the top skills for Data Analytics based on salary?
- Look at the average salary associated with each skill for Data Analyst 
  Positions in Tampa, FL
- Focus on roles with specified salaries (Not Null) in Tampa, FL
- Why? It reveals how different skills impact salary levels for Data
  Analysts and helps identify the most financially rewarding skills
  to acquire and improve upon for the job market.

*/


SELECT
  skills,
  ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_title_short = 'Data Analyst'
  AND job_location LIKE '%Tampa,_FL%'
  AND salary_year_avg IS NOT NULL
GROUP BY
  skills
ORDER BY
  avg_salary DESC
LIMIT 25


/*

Here's the breakdown of the most beneficial skills based on salary

- Demand for both traditional (MySQL, Oracle) and modern 
  (Hadoop, Snowflake) data management technologies.
- Need for proficiency in programming languages like Python and R, 
  alongside data visualization tools (PowerPoint, Excel).
- Growing emphasis on big data technologies, cloud computing, and 
  application development frameworks (React, Flask), indicating a 
  shift towards advanced analytics and cloud-based solutions.

- RESULT SET OF QUERY IN JSON FORMAT - 

[
  {
    "skills": "phoenix",
    "avg_salary": "138640.00"
  },
  {
    "skills": "powerpoint",
    "avg_salary": "136225.00"
  },
  {
    "skills": "mysql",
    "avg_salary": "132315.00"
  },
  {
    "skills": "nosql",
    "avg_salary": "125665.00"
  },
  {
    "skills": "linux",
    "avg_salary": "120000.00"
  },
  {
    "skills": "word",
    "avg_salary": "119918.75"
  },
  {
    "skills": "hadoop",
    "avg_salary": "116729.00"
  },
  {
    "skills": "snowflake",
    "avg_salary": "112880.00"
  },
  {
    "skills": "react",
    "avg_salary": "111175.00"
  },
  {
    "skills": "flask",
    "avg_salary": "111175.00"
  },
  {
    "skills": "shell",
    "avg_salary": "110000.00"
  },
  {
    "skills": "oracle",
    "avg_salary": "109238.53"
  },
  {
    "skills": "javascript",
    "avg_salary": "108271.67"
  },
  {
    "skills": "databricks",
    "avg_salary": "106666.67"
  },
  {
    "skills": "kafka",
    "avg_salary": "106345.00"
  },
  {
    "skills": "cognos",
    "avg_salary": "105786.03"
  },
  {
    "skills": "alteryx",
    "avg_salary": "105000.00"
  },
  {
    "skills": "spreadsheet",
    "avg_salary": "105000.00"
  },
  {
    "skills": "spark",
    "avg_salary": "104230.00"
  },
  {
    "skills": "flow",
    "avg_salary": "101716.00"
  },
  {
    "skills": "r",
    "avg_salary": "101216.92"
  },
  {
    "skills": "python",
    "avg_salary": "100954.67"
  },
  {
    "skills": "vba",
    "avg_salary": "100291.25"
  },
  {
    "skills": "pandas",
    "avg_salary": "100000.00"
  },
  {
    "skills": "numpy",
    "avg_salary": "100000.00"
  }
]

*/