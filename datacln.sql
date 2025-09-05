use datacl;
select * from layoffs;

## Data Cleaning 

select * from layoffs;
#original data should be kept intact so a copy of the data is created to be used for further data cleaning and alteration

                                          ##creating the original date copy##
CREATE TABLE `layoffs_cld` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` bigint DEFAULT NULL,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `R_No` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;        
	  -- table created with an additional r_no coloumn for row number for the purpose of removing duplicates# 


## inserting original data copy into the new table ##

select * from layoffs_cld;
insert into layoffs_cld
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions)R_no
from layoffs;
	-- row number inserted to find out duplicate data sets

                      ## Deletion of duplicate data sets ##
DELETE from 
layoffs_cld 
where r_no > 1;
select * from layoffs_cld where r_no > 1;
-- all data sets with r_no(row number) greater than 1 are identified as duplicates and deleted


## using trim coommand to remove excess space from data

select * from layoffs_cld;

select distinct company,trim(company) from layoffs_cld order by 1;

UPDATE LAYOFFS_CLD 
set company = trim(company);
UPDATE layoffs_cld
set location = trim(location);
UPDATE layoffs_cld
set industry = trim(industry);
UPDATE layoffs_cld
set stage = trim(stage);
UPDATE layoffs_cld
set country = trim(country);


select distinct industry from layoffs_cld;
select * from layoffs_cld
where industry like 'crypto%';
-- crypto, crypto currency & cryptocurrency data in the industry coloumn can be recognised as crypto itself

-- replacing the above mentioned industries as crypto
UPDATE layoffs_cld
set industry = 'crypto'
where industry like "crypto%";


select distinct country from layoffs_cld order by 1;
select * from layoffs_cld where country like 'united s%';

-- removal of trailing values from the country coloumn

UPDATE layoffs_cld
set country = trim(trailing '.' from country)
where country like'united s%';

-- converting date column from text format to date format
UPDATE layoffs_cld 
set date = 
str_to_date(date,'%m/%d/%Y');

ALTER table layoffs_cld
modify `date` date;

            ## filling null and empty values in the industry coloumn ##

select * from  layoffs_cld;
select distinct industry from layoffs_cld order by 1;

select * from layoffs_cld 
where industry = '' or industry is null;

UPDATE layoffs_cld
set industry = null where industry = '';

-- checking the fillable values
select t1.industry,t2.industry
 from 
layoffs_cld t1 join
layoffs_cld t2 on
t1.company = t2.company
where t1.industry is null 
and t2.industry is not null;

-- updating the null values with other possible values
update layoffs_cld t1
join layoffs_cld t2 
on t1.company=t2.company
set t1.industry=  t2.industry
where t1.industry is null
and t2.industry is not null;


                   ##  Removal of data which are not required for exploratory data analysis  ##
 
 -- identifying the unwanted data sets
 select * from layoffs_cld;
 select * from layoffs_cld where 
 total_laid_off is null and percentage_laid_off is null;
 
 -- deletion of identified data sets
 DELETE from layoffs_cld
 where 
 total_laid_off is null and percentage_laid_off is null;
 
 
-- deletion of R_no coloumn from data since it is no longer necessary
ALTER table layoffs_cld drop column R_no;
 select * from layoffs_cld;
 
 -- PERCENTAGE LAID OFF coloumn 
 select distinct percentage_laid_off from layoffs_cld;
 -- the only values in the percentage_laid_off coloumn are zero, null and 1
 alter table layoffs_cld drop column percentage_laid_off;
 select * from layoffs_cld;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 