create database Project_1;

use project_1;

select * from hr_1;
select * from hr_2;
drop table hr_2;

alter table hr_1 rename column EmployeeNumber TO  EmployeeID;

SELECT Count(EmployeeCount) AS Total_Employees
FROM hr_1;

-- -----  1  ---- AVERAGE ATTRITION RATE FOR ALL DEPARTMENTS --#######################

SELECT Department, 
CONCAT((ROUND(SUM(CASE WHEN attrition = "Yes" THEN 1 ELSE 0 END)/ count(employeeid)*100,2)),' %') AS Attrition_Rate
FROM hr_1
GROUP BY Department;

-- 2  --AVERAGE HOURLY RATE OF MALE RESEARCH SCIENTIST --############################

SELECT JobRole,Gender, CONCAT(ROUND(AVG(HourlyRate),2),' %') AS Avg_HourlyRate 
FROM hr_1
WHERE JobRole = "research scientist" && gender = "male"
GROUP BY JobRole;

-- 3 -- Attrition rate Vs AvgMonthly income stats --#########################

SELECT hr_1.Department,
CONCAT(ROUND(SUM(CASE WHEN attrition = "yes" THEN 1 ELSE 0 END)/ COUNT(hr_1.EmployeeID)*100,2),'%') AS Attrition_Rate,
ROUND(AVG(hr_2.MonthlyIncome)) AS Avg_MonthlyIncome
FROM hr_1 INNER JOIN hr_2
ON hr_1.EmployeeID = hr_2.EmployeeID
GROUP BY 1;

-- 4 -- AVERAGE WORKING YEARS FOR EACH DEPARTMENT --##############################

SELECT hr_1.Department, ROUND(AVG(hr_2.TotalWorkingYears),2) AS Avg_Working_Years
FROM hr_1 JOIN hr_2
ON hr_1.EmployeeID = hr_2.EmployeeID
GROUP BY hr_1.Department;


-- 5 -- Job Role Vs Work life balance --##########################################
 
SELECT DISTINCT(hr_1.JobRole),(CASE
WHEN hr_2.WorkLifeBalance = 1 THEN "1.Poor" 
WHEN hr_2.WorkLifeBalance = 2 THEN "2.Average" 
WHEN hr_2.WorkLifeBalance = 3 THEN "3.Good" 
ELSE "4.excellent"END) 
AS worklifebal_status,
COUNT(hr_2.WorkLifeBalance) 
as count_worklifebalance from hr_1 inner join hr_2
on hr_1.EmployeeID = hr_2.EmployeeID
group by 1 ,2
order by worklifebal_status asc,count_worklifebalance desc;
 

-- 6 -- ATTRITIONRATE VS YEARSINCE LAST PROMOTION --########################

SELECT hr_1.Department,CONCAT(ROUND(SUM(CASE WHEN attrition = "Yes" THEN 1 ELSE 0 END )/COUNT(hr_1.employeeCount)*100,2),'%') AS Atr_Rate, 
ROUND(AVG(hr_2.YearsSinceLastPromotion),2) AS avg_YearsSinceLastPromotion
FROM hr_1 INNER JOIN hr_2
ON hr_1.EmployeeID = hr_2.EmployeeID
GROUP BY 1;





##-----Extra KPIs------


-- -- COUNT OF FEMALE EMPLOYEES --
SELECT Count( * )AS Female_EmployeeCount
FROM hr_1
WHERE Attrition = "Yes" and Gender = "Female";


-- -- Count of male Employees --
SELECT Count( * ) AS Male_EmployeeCount
FROM hr_1
WHERE Attrition = "Yes" AND Gender = "male";


-- -- ATTRITION RATE --
SELECT CONCAT(ROUND(SUM(CASE WHEN attrition = "yes" THEN 1 ELSE 0 end)/ COUNT(EmployeeCount)*100,2),'%') AS AttritionRate
FROM hr_1;



-- -- Employee Average Age --
SELECT ROUND(AVG(age)) AS Average_Age FROM hr_1;



-- -- Avg_EnvironmentSatisfaction --

SELECT ROUND(AVG(EnvironmentSatisfaction),3) AS Avg_Environment_Satisfaction FROM hr_1;



-- -- Avg JobSatisfaction --

SELECT ROUND(AVG(JobSatisfaction),3) AS Avg_Job_Satisfaction_Rate FROM hr_1;



-- -- Avg Performance Rating --

SELECT ROUND(AVG(PerformanceRating),3) AS Performance_Rating FROM hr_2;



-- --  Avg Work Life Balance -- 

SELECT ROUND(AVG(WorkLifeBalance),3) AS AvgWorkLifeBalance FROM hr_2;



#################################################__________________________#################################################