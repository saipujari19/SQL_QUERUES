SELECT * FROM PortfolioProject..CovidDeaths
WHERE continent is not null
order by 3,4


--SELECT * FROM PortfolioProject..CovidVaccinations order by 3,4

-- selectig data that we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths 
WHERE continent is not null
order by 1,2


-- looking at total cases vs total deaths


SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths 
WHERE location like '%states%'

--WHERE location = 'united states'
ORDER BY 1,2 

--LOOKING TOTAL CASES VS POPULATION
--SGOWING WHAT PERCENTAGE OF POPULATION GOT COVID

SELECT location, date, population,total_cases, (total_cases/population)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths 
WHERE continent is not null
and location like '%ind%'
ORDER BY 1,2 

--LOOKING AT COUNTRIES WITH HIGHEST INFECRION RATE COMPARED TO POPULATION, OUT OF WHICH ARE TOP 10


SELECT TOP 10 location, population,MAX(total_cases) AS HighestInfectionRate, MAX((total_cases/population))*100 AS PercentPopulatedInfected
FROM PortfolioProject..CovidDeaths 
WHERE continent is not null
GROUP BY location, population
ORDER BY  PercentPopulatedInfected


--LOOKING AT COUNTRIES WITH HIGHEST INFECRION RATE COMPARED TO POPULATION


SELECT location, population,MAX(total_cases) AS HighestInfectionRate, MAX((total_cases/population))*100 AS PercentPopulatedInfected
FROM PortfolioProject..CovidDeaths 
WHERE continent is not null
--WHERE location like '%ind%'
GROUP BY location, population
ORDER BY  PercentPopulatedInfected DESC

--COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION 
--cast converting nvarchar to int

SELECT location, MAX(cast(total_deaths as int)) AS HIGHESTDEATHCOUNT
FROM PortfolioProject..CovidDeaths 
WHERE continent is not null
--WHERE location like '%ind%'
GROUP BY location
ORDER BY HIGHESTDEATHCOUNT DESC

--LET'S BREAK DOWN BY CONTINENT


--SELECT continent, MAX(cast(total_deaths as int)) AS HIGHESTDEATHCOUNT
--FROM PortfolioProject..CovidDeaths 
--WHERE continent is not null
----WHERE location like '%ind%'
--GROUP BY continent
--ORDER BY HIGHESTDEATHCOUNT DESC

SELECT location, MAX(cast(total_deaths as int)) AS HIGHESTDEATHCOUNT
FROM PortfolioProject..CovidDeaths 
WHERE continent is null
--WHERE location like '%ind%'
GROUP BY location
ORDER BY HIGHESTDEATHCOUNT DESC

--SHOWING CONTINENT WITH THE HIGHEST DEATH COUNT PER POPULATION

SELECT continent, MAX(cast(total_deaths as int)) AS HIGHESTDEATHCOUNT
FROM PortfolioProject..CovidDeaths 
WHERE continent is not null
--WHERE location like '%ind%'
GROUP BY continent
ORDER BY HIGHESTDEATHCOUNT DESC

--GLOBAL NUMBERS

SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths AS INT)) as total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null 
--GROUP BY date
ORDER BY 1,2

--LOOKING TOTAL POPULATION VS VACCINATION

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
FROM
PortfolioProject..CovidDeaths dea
join
PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
order by 2,3

--use CTE

WITH PopvsVac(continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
FROM
PortfolioProject..CovidDeaths dea
join
PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3
)
SELECT *,(RollingPeopleVaccinated/population)*100
FROM PopvsVac

--USING TEMP TABLE

DROP TABLE IF EXISTS #PercentPeopleVaccinated
CREATE TABLE #PercentPeopleVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPeopleVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
FROM
PortfolioProject..CovidDeaths dea
join
PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
--WHERE dea.continent is not null
--order by 2,3

SELECT *,(RollingPeopleVaccinated/population)*100
FROM #PercentPeopleVaccinated

--CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS

CREATE VIEW PercentPeopleVaccinated AS

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
FROM
PortfolioProject..CovidDeaths dea
join
PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3

SELECT * FROM PercentPeopleVaccinated