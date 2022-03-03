-- Making sure that the database is correctly imported
select * from portfolio.dbo.covid

-- General summary of the data itself
select location , date , total_cases , new_cases , total_deaths , population
from portfolio.dbo.covid
where continent is not null
order by 1,2

-- Death percentage of Turkey 
select location ,date,total_cases , total_deaths , date ,(total_deaths/total_cases)*100 as DeathPercentageTurkey
from portfolio.dbo.covid
where location = 'turkey'
and continent is not null
order by DeathPercentageTurkey DESC

-- Total cases vs population in Turkey ( Percentage of the population that got infected )
select location ,date, population,total_cases, (total_cases/population)*100 as InfectedPercentage
from portfolio.dbo.covid
where location ='Turkey'
and continent is not null
order by InfectedPercentage DESC

-- Highest infected population rate for every country
select location , population , Max(total_cases) as HighestInfectionCount , Max((total_cases/population))*100 as PopulationInfectedPercent
from portfolio.dbo.covid
where continent is not null
Group by location , population
order by PopulationInfectedPercent DESC

-- Countries with the highest death count
select location , max(cast(total_deaths as int)) as TotalDeathCount
from portfolio.dbo.covid
where continent is not null
group by location
order by TotalDeathCount DESC

-- Continents with the highest death count
select continent , max(cast(total_deaths as int)) as TotalDeathCount
from portfolio.dbo.covid
where continent is not null
group by continent
order by TotalDeathCount DESC

-- Global totals
select SUM(new_cases) as TotalCases , SUM(cast(new_deaths as int)) as TotalDeaths , SUM(cast(new_deaths as int))/ SUM(new_cases) *100 as DeathPercentage
from portfolio.dbo.covid
where continent is not null 
order by 1,2

-- Total population of countries vs vaccination
select continent , location ,date ,population, people_vaccinated 
from portfolio.dbo.covid
where continent is not null
and people_vaccinated is not null
order by 2,3


-- Population vs vaccination in Turkey
select continent , location ,date ,population, people_vaccinated 
from portfolio.dbo.covid
where continent is not null
and people_vaccinated is not null
and location = 'Turkey'
order by 2,3

-- Covid relation with ages
	-- 70 or older death rate
select DISTINCT (location) , (aged_70_older/population)*100 as Over70
from portfolio.dbo.covid
where continent is not null
and aged_70_older is not null
order by 2 DESC

	-- 65 or older death rate
select DISTINCT (location) , (aged_65_older/population)*100 as Over65
from portfolio.dbo.covid
where continent is not null
and aged_65_older is not null
order by 2 DESC

