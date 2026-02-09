# Job_Market_Analysis_SQL
Job market Analysis

📊 Job Market & Skills Analysis using SQL and Python
📌 Project Overview

This project is an end-to-end real-world data analytics case study focused on analyzing the data job market.
The goal is to help job seekers, recruiters, and edtech teams understand:

Which data roles pay the most

Which skills are most in demand

Which skills offer the best balance of high demand and high salary

The project demonstrates how raw job posting data can be transformed into business-ready insights using SQL and Python (Pandas).

🎯 Business Problem

As a Data Analyst, you are tasked with answering the following business questions:

Which data roles (Data Analyst, Data Engineer, Data Scientist) offer the highest salaries?

What are the most in-demand technical skills (SQL, Python, Power BI, Tableau, Excel)?

Which skills provide the best career opportunity based on both demand and salary?

How can learners prioritize skills for maximum career ROI?

🗂️ Dataset Description

The project uses three relational datasets simulating real-world job market data.

1️⃣ job_postings_fact
Column Name	Description
job_id	Unique job identifier
job_title	Full job title
job_title_short	Standardized role name
job_location	Job location
job_schedule_type	Full-time / Contract
job_work_from_home	Remote indicator
salary_year_avg	Average yearly salary
job_posted_date	Job posting date
2️⃣ skills_dim
Column Name	Description
skill_id	Unique skill identifier
skills	Skill name (SQL, Python, Tableau, etc.)
3️⃣ skills_job_dim
Column Name	Description
job_id	Job identifier
skill_id	Skill identifier

This table represents a many-to-many relationship between jobs and skills.

🛠️ Tools & Technologies Used

SQL (MySQL)

JOINs

Aggregations

CTEs

Filtering & Sorting

Python

Pandas

SQLAlchemy

Database

MySQL

Version Control

Git & GitHub

🔍 Project Workflow
✅ Step 1: Data Inspection & Cleaning

Inspected schemas

Removed records with missing salary values

Filtered to relevant roles and remote jobs

✅ Step 2: Exploratory SQL Analysis

Identified top-paying remote Data Analyst roles

Analyzed salary distribution across roles

✅ Step 3: Skills Demand Analysis

Joined job and skill tables

Calculated demand counts for each skill

✅ Step 4: Salary by Skill

Computed average salary per skill

Ranked skills by earning potential

✅ Step 5: Opportunity Score (Advanced Analysis)

Combined demand + salary using CTEs

Built an opportunity score to identify high-value skills

📈 Key Insights

SQL is the most in-demand skill across Data Analyst roles

Python offers higher average salaries with slightly lower competition

Power BI & Tableau provide strong opportunities with moderate demand

The best learning path:

SQL → Python → BI Tools

💡 Business Impact

Helps job seekers prioritize skills strategically

Supports edtech platforms in curriculum planning

Assists recruiters in understanding market trends

Demonstrates how data drives real hiring decisions

🧠 What This Project Demonstrates

✔ Real-world problem solving
✔ Strong SQL fundamentals (JOINs, CTEs, aggregates)
✔ Python-to-SQL integration
✔ Business-focused thinking
✔ Portfolio-ready analytics project

🚀 How to Use This Project

Clone the repository

Load CSV files into MySQL using Python

Run SQL queries for analysis

Explore insights or extend analysis by:

Adding new roles

Performing time-series analysis

Visualizing results using Power BI / Tableau

📂 Repository Structure
├── data/
│   ├── job_postings_fact.csv
│   ├── skills_dim.csv
│   ├── skills_job_dim.csv
├── sql/
│   ├── job_market_analysis.sql
├── python/
│   ├── load_data_to_mysql.py
│   ├── analysis_with_pandas.py
├── README.md

📣 How to Explain This Project in Interviews

“I analyzed real job posting data to understand which data skills are both highly demanded and highly paid. I used SQL joins and CTEs to combine job and skill data, then created an opportunity score to help learners and recruiters make informed decisions.”

📬 Contact

Author: Pavan Anipireddy
Role: Aspiring Data Analyst
Skills: SQL | Python | Pandas | MySQL | Data Analytics
