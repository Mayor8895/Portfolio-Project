--data to use
select location,date,total_cases,new_cases,total_deaths, population from CovidDeaths

--total cases vs total death
select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from CovidDeaths
--where location like 'nigeria'
order by 1,2

--total cases vs population
select location,date,population,total_cases, (population/total_cases)*100 as DeathPercentage
from CovidDeaths
--where location like 'nigeria'
where continent is not null
order by 1,2

country with highest infection rate
select location,population, max(total_cases) as HighestInfectionCount,max((total_cases/population))*100 as PercentagePopulationInfected
from CovidDeaths
group by location,population
order by PercentagePopulationInfected desc

--Breaking things down to continent
select continent, max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths
--where location like 'nigeria'
where continent is not null
group by continent
order by totaldeathcount desc

--Global numbers
select sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from CovidDeaths
where continent is not null order by 1,2

--total population vs vaccination


--Create view

create view  PercentagePopulationVaccinated as
select dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
from CovidDeaths dea
join  CovidVaccinations vac
on dea.location = dea.location
and vac.date = vac.date
--order by 2,3


