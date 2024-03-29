/*
What are the top paying data analyst jobs?
-Identify the top 10 highest paying data analystr roles that are available remotely
- Focus on job postings with specified salaries (remove nulls)
- Why? Highlight the top paying opportunities for Data Analysts, offering insights into emp
*/

SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.job_schedule_type,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location LIKE '%Tampa,_FL%'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10 

/*
Here is the breakdown of the top 10 highest paying Data Analyst jobs
in Tampa, FL in 2023

- Citi bank/ Citigroup seems to lead all other companies with the
  exception of USAA having one posting.
- Highest pay for Citi Bank ranges from around $132,000 up to
  $188,000 annually for Data Analyst Type positions
- The one position through USAA pays roughly $138,000 annually

- RESULT SET OF QUERY IN JSON FORMAT - 

[
  {
    "job_id": 1026268,
    "job_title": "SVP, Credit Risk Digital Transformation Senior Business/Data Analyst",
    "job_location": "Tampa, FL",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "188675.0",
    "job_posted_date": "2023-05-15 19:01:49",
    "company_name": "Citi"
  },
  {
    "job_id": 1187886,
    "job_title": "ICM CCR Data Analyst",
    "job_location": "Tampa, FL",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "150000.0",
    "job_posted_date": "2023-03-23 12:03:59",
    "company_name": "Citigroup, Inc"
  },
  {
    "job_id": 1197871,
    "job_title": "Digital Marketing Data Analyst (Hybrid)",
    "job_location": "Tampa, FL",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "138640.0",
    "job_posted_date": "2023-06-01 07:23:19",
    "company_name": "USAA"
  },
  {
    "job_id": 178496,
    "job_title": "Data Management Lead Analyst (Hybrid)",
    "job_location": "Tampa, FL",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "137610.0",
    "job_posted_date": "2023-07-03 10:01:59",
    "company_name": "Citi"
  },
  {
    "job_id": 1012175,
    "job_title": "ICM CCR Data Analyst",
    "job_location": "Tampa, FL",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "137610.0",
    "job_posted_date": "2023-03-27 08:04:47",
    "company_name": "Citi"
  },
  {
    "job_id": 1470914,
    "job_title": "Data Analyst",
    "job_location": "Tampa, FL",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "137610.0",
    "job_posted_date": "2023-08-03 14:02:41",
    "company_name": "Citi"
  },
  {
    "job_id": 795863,
    "job_title": "Data Analyst",
    "job_location": "Tampa, FL",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "137610.0",
    "job_posted_date": "2023-08-07 09:19:03",
    "company_name": "Citi"
  },
  {
    "job_id": 1573441,
    "job_title": "Data Analyst. Job in Tampa LilyLifestyle Jobs",
    "job_location": "Tampa, FL",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "137610.0",
    "job_posted_date": "2023-08-07 09:19:17",
    "company_name": "Citi"
  },
  {
    "job_id": 42577,
    "job_title": "Data Analyst. Job in Tampa NBC4i Jobs",
    "job_location": "Tampa, FL",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "137610.0",
    "job_posted_date": "2023-08-03 14:02:44",
    "company_name": "Citi"
  },
  {
    "job_id": 1133532,
    "job_title": "Vice President - Lead AML Data Science Analyst- Hybrid",
    "job_location": "Tampa, FL",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "132315.0",
    "job_posted_date": "2023-03-08 10:01:45",
    "company_name": "Citi"
  }
]

*/