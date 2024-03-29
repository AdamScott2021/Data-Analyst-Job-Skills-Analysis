/*

Question: What are the most optimal skills to learn (i.e. what skills 
are in demand)

- Identify skills in high demand and associated with average salaries
  for Data Analyst roles
- Concentrates on roles in Tampa, FL where the salary is NOT NULL
- Why? Targets skills that offer job security and financial benefits
  offering strategic insights for career development in data analysis

*/
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location LIKE '%Tampa,_FL%'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id, skills_dim.skills -- Added skills_dim.skills here
    LIMIT 25
),
average_salary AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
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
        skills_dim.skill_id, skills_dim.skills -- Added skills_dim.skills here
    LIMIT 25
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25




/*

Here's the breakdown of the most beneficial skills to learn

SQL: SQL tops the list with the highest demand count of 41. This indicates 
a significant need for data analysts proficient in database management and
querying, reflecting the foundational role of SQL in data analysis.

Python and R: Both Python and R are in demand, with 15 and 13 mentions, 
respectively. This highlights the importance of statistical programming 
languages in data analysis tasks, suggesting a need for skills in data 
manipulation, statistical analysis, and visualization.

Oracle, Snowflake, and Databricks: These technologies are also in demand, 
with Oracle leading with 6 mentions, followed by Snowflake and Databricks 
with 3 mentions each. This suggests a requirement for expertise in database 
management systems, cloud data warehousing, and big data processing 
platforms.

JavaScript and Spark: JavaScript and Spark both have 3 mentions, indicating
a growing need for skills in web development and distributed computing 
frameworks, respectively, within the Tampa Bay area.

Azure: Microsoft Azure is mentioned 4 times, indicating a demand for skills 
in cloud computing and data analytics services provided by the Azure 
platform.

Data Science Libraries: Pandas and NumPy are mentioned 2 times each, 
emphasizing the importance of data manipulation and numerical computing 
libraries in data analysis workflows.

Other Skills: Other skills like SAS, C++, Java, and Shell scripting also 
have mentions, albeit fewer. This suggests niche demands for specific tools 
or technologies within certain industries or organizations.

- RESULT SET OF QUERY IN JSON FORMAT - 

[
  {
    "skill_id": 0,
    "skills": "sql",
    "demand_count": "41",
    "avg_salary": "90788.44"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "15",
    "avg_salary": "100954.67"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "13",
    "avg_salary": "101216.92"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "demand_count": "10",
    "avg_salary": "69732.62"
  },
  {
    "skill_id": 22,
    "skills": "vba",
    "demand_count": "8",
    "avg_salary": "100291.25"
  },
  {
    "skill_id": 23,
    "skills": "crystal",
    "demand_count": "7",
    "avg_salary": "61428.57"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "6",
    "avg_salary": "109238.53"
  },
  {
    "skill_id": 16,
    "skills": "t-sql",
    "demand_count": "6",
    "avg_salary": "60000.00"
  },
  {
    "skill_id": 13,
    "skills": "c++",
    "demand_count": "5",
    "avg_salary": "91000.00"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "4",
    "avg_salary": "100000.00"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "demand_count": "4",
    "avg_salary": "99178.75"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "4",
    "avg_salary": "97500.00"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "3",
    "avg_salary": "112880.00"
  },
  {
    "skill_id": 9,
    "skills": "javascript",
    "demand_count": "3",
    "avg_salary": "108271.67"
  },
  {
    "skill_id": 75,
    "skills": "databricks",
    "demand_count": "3",
    "avg_salary": "106666.67"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "demand_count": "3",
    "avg_salary": "104230.00"
  },
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "3",
    "avg_salary": "87891.67"
  },
  {
    "skill_id": 2,
    "skills": "nosql",
    "demand_count": "2",
    "avg_salary": "125665.00"
  },
  {
    "skill_id": 6,
    "skills": "shell",
    "demand_count": "2",
    "avg_salary": "110000.00"
  },
  {
    "skill_id": 84,
    "skills": "ibm cloud",
    "demand_count": "2",
    "avg_salary": "100000.00"
  },
  {
    "skill_id": 93,
    "skills": "pandas",
    "demand_count": "2",
    "avg_salary": "100000.00"
  },
  {
    "skill_id": 94,
    "skills": "numpy",
    "demand_count": "2",
    "avg_salary": "100000.00"
  },
  {
    "skill_id": 56,
    "skills": "mysql",
    "demand_count": "1",
    "avg_salary": "132315.00"
  },
  {
    "skill_id": 10,
    "skills": "html",
    "demand_count": "1",
    "avg_salary": "80000.00"
  },
  {
    "skill_id": 11,
    "skills": "css",
    "demand_count": "1",
    "avg_salary": "60000.00"
  }
]


*/