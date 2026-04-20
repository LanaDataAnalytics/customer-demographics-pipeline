SELECT 
  data_quality_status,
  COUNT(customer_id) as total_records,
  ROUND(COUNT(customer_id) / (SELECT COUNT(*) FROM `portfolio-eda-project.raw_data.mart_crm_demographics`) * 100, 2) AS percentage_of_database
FROM `portfolio-eda-project.raw_data.mart_crm_demographics`
GROUP BY 
  data_quality_status
ORDER BY 
  total_records DESC;