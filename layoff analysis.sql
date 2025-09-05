USE datacl;
select * from layoffs_cld;

                              ## -- EXPLORATORY DATA ANALYSIS -- ##
                              #data set contains 1090 days worth of data from different companies
							                #from 11/03/2020 to 06/03/2023
											#1995 rows of data post cleaning
                              #findings done with the given data are as follows:
							    -- total layoffs done by each company 
                                -- average layoffs done across all the companies
								-- total layoffs done country wise with top 5 countries having the most layoffs
							    -- country wise average layoffs 
								-- industry wise layoffs ranked 
                                -- year wise layoff data
								-- monthwise rolling sum of layoffs 
								-- year wise top 5 companies that carried out most layoffs
								-- Distribution of Total Layoffs Across Countries (%)
							

-- checking the start and end date of the data  

select min(date),max(date) from layoffs_cld; 

select datediff(max(`date`),min(`date`)) no_of_days
from layoffs_cld;

-- data set contains 1090 days worth of data from different companies

#________________________________________________________________#

select company,sum(total_laid_off) total_layoffs
from layoffs_cld
group by 1 order by 2 desc;
   -- total layoffs done by each company --

with ab as(
select company,sum(total_laid_off) total_layoffs
from layoffs_cld
group by 1 order by 2 desc)
select floor(avg(total_layoffs)) average from ab;
    -- average layoffs done across all the companies --
    
#__________________________________________________________________#    
  
select country, sum(total_laid_off) total_layoffs
from layoffs_cld
where total_laid_off is not null
group by 1 order by 2 desc limit 5 ;
 -- total layoffs done country wise with top 5 countries having the most layoffs --
 
 
 #_____________________________________________________________________#
 with ab as(
select country,sum(total_laid_off) total_layoffs
from layoffs_cld
group by 1 order by 2 desc)
select floor(avg(total_layoffs)) average from ab;
  -- country wise average layoffs --
  
  
#______________________________________________________________________#
  select industry,sum(total_laid_off) total_layoffs,
  dense_rank()over(order by sum(total_laid_off)desc)RnK
from layoffs_cld where total_laid_off is not null
group by 1 order by 2 desc limit 5;
    -- industry wise layoffs ranked --

    
#_____________________________________________________________________#
    select year(date)year,sum(total_laid_off)Total_layoffs
    from layoffs_cld
    where date is not null
    group by 1 order by 1;
	-- year wise layoff data --
   
#__________________________________________________________________#
   with cte as 
   ( select substring(date ,1,7)month_yr,sum(total_laid_off)tot_layoff 
    from layoffs_cld
    where date is not null
    group by 1)
    select month_yr,tot_layoff,sum(tot_layoff) over (order by month_yr) rolling_sum_of_layoffs
    from cte
    group by 1;
      -- monthwise rolling sum of layoffs --
      
#_________________________________________________________________#
    with ab as 
    (  select company,year(date)year,sum(total_laid_off) layoffs
    from layoffs_cld
    where total_laid_off is not null and `date` is not null
    group by 1,2),
    ac as
    (select company,year,layoffs,
    dense_rank()over(partition by year order by layoffs desc)rnk
   from ab)
   select * from ac where rnk <= 5;
   -- year wise top 5 companies that carried out most layoffs --
  

#_________________________________________________________________________#
   with ab as
   (
   select country,sum(total_laid_off)layoffs,
   sum(sum(total_laid_off)) over() as tot_layoffs
   from layoffs_cld
   where total_laid_off is not null
   group by 1
   )
   #creating table ab with necessary values from layoffs_cld   
   select country,layoffs,
   concat(round((layoffs/tot_layoffs)*100,2) ,'%') 
   as layoffs_percentage
   #calculation of country wise percentage of total layoffs from ab

   from ab
   order by layoffs desc;
          
          -- Distribution of Total Layoffs Across Countries(%)
    