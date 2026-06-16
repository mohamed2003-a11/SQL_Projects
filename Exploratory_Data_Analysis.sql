-- Exploratory Data Analysis 
 
select *
from layoffs_staging2;

select max(total_laid_off)
from layoffs_staging2;

select percentage_laid_off,funds_raised_millions
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions  DESC ;  

select company,sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 DESC;

select country,sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 DESC;

select Year(`data`),sum(total_laid_off)
from layoffs_staging2
group by Year(`data`)
order by 2 DESC;

select stage,sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 DESC;

select substring(`date`,6,2) as `Month`,sum(total_laid_off)
from layoffs_staging2
where substring(`date`,6,2)  is not null
group by `Month`
order  by  1 asc;

select * 
from layoffs_staging2;

with Roling_Total as
(
select substring(`date`,1,7) as `Month`,sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7)  is not null
group by `Month`
order  by  1 asc
)
select `Month`,total_off
,sum(total_off)over(order by `MONth`)as rolling_total
from Roling_Total;

select company,sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 DESC;

select company,year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company,`date`
order by 3 desc;

with Company_Year (Company,Years,total_laid_off) as
(
select company,year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company,`date`
) 
,Company_year_ranking as
(select * , dense_rank() over(partition by years order by total_laid_off desc ) as ranking
from Company_year
where years is not null
order by ranking)
select *
from Company_year_ranking 
where ranking <= 5 ;