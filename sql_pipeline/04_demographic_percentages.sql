SELECT 
  country_name,
  gender_clean,
  COUNT(customer_id) AS total_gender_count,
  
  -- Calculates what percentage this gender represents within its specific country
  ROUND(COUNT(customer_id) / SUM(COUNT(customer_id)) OVER(PARTITION BY country_name) * 100, 2) AS gender_percentage_in_country

FROM `portfolio-eda-project.raw_data.mart_crm_demographics`
WHERE gender_clean IN ('MALE', 'FEMALE') 
  AND data_quality_status = 'Clean Data'
GROUP BY 
  country_name,
  gender_clean
ORDER BY 
  country_name ASC, 
  total_gender_count DESC;