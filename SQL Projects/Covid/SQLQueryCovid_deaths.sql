--ALTER TABLE portfolio_project_covid..covid_deaths
--ALTER COLUMN total_deaths FLOAT;


select *
from portfolio_project_covid..covid_deaths
order by 3,4

--select *
--from portfolio_project_covid..covid_vaccinations
--order by 3,4


-- Select Data that we are going to be using
select location, date, total_cases, new_cases, total_cases, total_deaths, population
from portfolio_project_covid..covid_deaths where total_deaths >1
order by 1,2

-- Looking at total case vs total deaths
select location, date, total_cases, total_deaths, 
CASE
    WHEN total_deaths > 0 AND total_cases > 0 THEN
	round(CAST(total_deaths AS DECIMAL(20, 4)), 4) / round(CAST(total_cases AS DECIMAL(20, 4)), 4)*100
	ELSE 0
END AS death_percentage
from portfolio_project_covid..covid_deaths

-- Looking at total case vs total deaths
select location, date, total_cases, total_deaths, Round((total_deaths/total_cases)*100, 4) AS death_percentage
from portfolio_project_covid..covid_deaths
where location like '%new zea%'
order by 1, 2

-- total cases vs population
select location, date, population, total_cases, Round((total_cases/population)*100, 4) AS case_population_percentage
from portfolio_project_covid..covid_deaths
where location like '%new zea%'
order by 1, 2




-- total cases vs population
select location, MAX(population) as top_population, MAX(total_cases) as highest_infection_count, MAX(total_cases/population)*100 AS infection_rate_percentage
from portfolio_project_covid..covid_deaths
--where location like '%new z%'
group by location, population
order by 4 desc


-- total dealth vs population percentage
select location, MAX(population) as population, MAX(total_deaths) as total_deaths_count
from portfolio_project_covid..covid_deaths
where continent is not null--location like '%new z%'
group by location, population
order by 3 desc


-- total dealth vs population percentage
select continent, location, MAX(population) as population, MAX(total_deaths) as total_deaths_count
from portfolio_project_covid..covid_deaths
where continent is null--location like '%new z%'
group by continent, location, population -- , population
order by total_deaths_count desc

-- get continent

select distinct location
from portfolio_project_covid..covid_deaths
where continent is not null
order by 1


-- Global numbers
-- Looking at total case vs total deaths

select SUM(new_cases) as sum_of_cases, sum(new_deaths) as sum_of_deaths, Round(SUM(new_deaths)/sum(new_cases), 4)*100 as cases_death_percentage
from portfolio_project_covid..covid_deaths
where continent is not null -- AND sum_of_cases is not null
--group by date
order by 1, 2




-- create distinct population list for each country 
SELECT continent, location, MAX(population) as pop--, YEAR(date) as year
FROM PortfolioProjects..covid_deaths
WHERE continent is not null
GROUP BY continent, location--, YEAR(date)
ORDER BY 2

--WHERE continent is not null
