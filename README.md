# -- Introduction --
While diving head on into the job market of Data Analytics I wanted to focus on Data Analyst roles in the Tampa Bay area, specifically because I wanted to gain some insights regarding what would be the most productive and beneficial skills to improve upon. These insights would be based on exploring top paying jobs, in demand skills, and where high demand meets high salary within Tampa Bay in the Data Analytics field.    

# -- Background --

Driven by my need to become more proficient using SQL for Data Analysis while entering the job market, it's logical to do an analysis on the job market itself!

The data I used Hails from Luke Barousse (https://www.lukebarousse.com/sql) Which was a data set he compiled that's packed with valuable insights waiting for anyone to stumble upon. The data set includes insights on job titles, salaries, locations, and essential skills required for each position from all around the world!

### -- The Questions I Wanted Answers To --

1) What were the top paying Data Analyst positions in Tampa Bay area?
2) What skills are required for these positions?
3) What skills are most in demand for Data Analyst positions?
4) Which skills are associated with higher salaries?
5) What are the optimal skills to learn or improve upon?

# -- Tools I Used --

**SQL**: The backbone of my analysis! this allowed me to extract valuable insights to the questions stated above.
**PostgreSQL**: The database management system I'm the most comfortable using
**Visual Studio Code**: My go-to IDE for database management and executing these SQL queries
**PyCharm**: My preferred Python IDE for development. I mainly use this platform for Non-SQL related development
**MatPlotLib**: A PHENOMENAL library I used to plot the data I extracted from the database into histograms you'll see below
**Git & GitHub**: Essential for version control and sharing my work while also ensuring collaboration and project tracking

# -- The Analysis --

### Question 1 -  What were the top paying Data Analyst positions in Tampa Bay area?

First, I wanted to determine what the top paying jobs were for Data Analysts in the Tampa Bay area. This really prompted me to dive deeper into the reasons why these positions garnered the salary that they earned.

I spent a little time writing the code below to extract the data that I needed.

```sql
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
    job_title = 'Data Analyst'
    AND job_location LIKE '%Tampa,_FL%'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10 
```

Below is a histogram of the data the SQL query provided me.

![Top Salaries by Company Name](relative path here)

This answered my first question, great! But it wasn't necessarily helpful toward my goal of understanding the job market I was entering into. I decided to dive deeper into this which is what prompted me to go on to answer my next question...What skills are required for these positions?



### Question 2 - What skills are required for these positions?

The query below involved extracting data from two tables using a Left Join in order to match skills to each position listed from question 1. Doing this would allow me to visualize what skills are associated with the top paying jobs.

```sql
WITH top_paying_jobs AS(
SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.salary_year_avg,
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
)

SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    skills DESC
```
![Average Salary Based On Skill](relative path here)


This data allowed me to visualize which skills are related to each position, giving me insights as to what skills might be most beneficial for me to focus on. What was interesting to me was that many of these skills had relatively similar salary compensation hovering around $100,000 annually with the exception of JavaScript pulling in around $125,000. This data wasn't the most refined but brought up another question...Which skills are most in demand for Data Analyst positions? While knowing what skills are required for the top paying jobs, I figured it might be smart to delve into the concept of demand.



### Question 3 - What skills are most in demand for Data Analyst positions?

Doing some more digging (and a little more SQL coding) I came up with a way to extract what skills were required for jobs from the previous result set. Using that data i would be able to aggregate which skills are most in demand for Data Analysts. 

```sql
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
```

![Demand For Each Skill](relative path here)

Now that I knew what skills were the most in demand for the job market, I began to question what skills were associated with higher salaries overall.



### Question 4 - Which skills are associated with higher salaries?

At this point I understood what I was looking for, it seemed logical to know what skills would be correlated with the highest salaries for Data Analysts. These skills would be something I could strive to improve upon in order to be proficient and an asset within the industry. 

```sql
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
```

![Average Salary For Each Skill](relative path here)

At this point I thought that I would be done, my understanding of the job market would be complete and I could say for certain that I now had answered all the questions I needed. It didn't feel right though. It felt like I still hadn't understood exactly what I set out to understand.



### Question 5 - What are the optimal skills to learn or improve upon?

This was the question...The crux of what I was looking for! Sure, its good to know what skills receive higher salaries but that doesn't help me in the end. What would truly benefit me in the end is to have some insight regarding what skills would be most beneficial for me to learn or improve upon.  The query below involved me taking the queries from questions 3 and 4 and expanding upon them to create one query that would ideally give me an idea of what skills would be optimal for my growth.

```sql
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
```

![Demand For Optimal Skill](relative path here)

At this point, I was satisfied. I'd identified what skills would be the most beneficial for my career as I entered into the Data Analytics job market. It is clear that a deep proficiency with SQL and Python would be most beneficial for me as well as using Tableau or Power BI to visualize the data in a meaningful way. Understanding R better is also helpful but I choose to rely on Python for its versatility beyond Data Analysis. Its interesting that Python libraries such as Pandas and NumPy seemed to be so low on the list but fortunately, I was already proficient with using them both. 


# --What I learned--

Overall, I was able to identify trends and specifics related to the job market in my area. I find this important because, well...to me it seems a bit useless to understand a job market that you're not involved in (unless im looking for remote work specifically). Beyond that, the most important take-away, to me at least, is that I became more proficient in using SQL and VS Code. It taught me how to think more critically and analytically in order to retrieve the data (and answers) I needed. Additionally, it gave me more experience in platforms that I wasn't exactly the most proficient in.  

# --Conclusions--

In Conclusion, It seems clear that SQL, Python, Excel, R, Power BI, and Tableau are all invaluable skills to be proficient in here in Tampa, FL. It never really dawned on me that certain geographical areas might put higher value on different skills but to me, its clear that this is the case. Overall, I plan to go deeper with other questions I have pertaining to completely different fields of study. In my pursuit for expert level proficiency using SQL, there will be many more databases I intend to query. Alongside this, I plan to integrate my proficiency with Python, NumPy, and Pandas into the equation and see what I can do. This certainly was a learning experience but I feel far more comfortable than I did prior to starting this project. 

### --Closing Thoughts--

This was fun. To some, it may seem boring and mundane but when you have a question that you just cant stop thinking about it's imperative to understand that with a bit of data you can likely find online pretty easily, critical thinking, and a determination to power through a learning curve, you can actually find some extremely valuable insights. Data is Beautiful, truly. It's literally the most powerful and priceless commodity we have in our current society and most people take it for granted. I would encourage anyone to explore this field at least a little bit, you might find the answer to questions you're looking for and better yet, answers to questions you didn't even know you wanted to ask. Thanks for reading, Random Human. 
