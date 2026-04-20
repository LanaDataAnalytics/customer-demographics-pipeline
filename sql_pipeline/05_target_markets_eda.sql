SELECT 
  country_name,
  customer_segment,
  COUNT(customer_id) as total_contacts
FROM `portfolio-eda-project.raw_data.mart_crm_demographics`
WHERE customer_segment IN ('1 - Academic & Medical', '2 - Gov & Civic')
GROUP BY 
  country_name, 
  customer_segment
ORDER BY 
  total_contacts DESC
LIMIT 10;