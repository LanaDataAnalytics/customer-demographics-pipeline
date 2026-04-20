CREATE OR REPLACE VIEW `portfolio-eda-project.raw_data.stg_customer_demographics` AS
SELECT 
  -- Anonymization
  CAST(ABS(FARM_FINGERPRINT(email)) AS STRING) AS customer_id, 
  
  -- Standardizing
  TRIM(LOWER(title)) AS title_clean,
  TRIM(UPPER(gender)) AS gender_clean,
  TRIM(INITCAP(city)) AS city_clean,
  TRIM(INITCAP(country)) AS country_name,
  TRIM(UPPER(country_code)) AS country_code_clean,
  
  -- Geography & Validation
  CAST(latitude AS FLOAT64) AS lat,
  CAST(longitude AS FLOAT64) AS lon,
  
  -- Geospatial Quality Check
  CASE 
    WHEN CAST(latitude AS FLOAT64) BETWEEN -90 AND 90 
     AND CAST(longitude AS FLOAT64) BETWEEN -180 AND 180 
     AND NOT (CAST(latitude AS FLOAT64) = 0 AND CAST(longitude AS FLOAT64) = 0)
    THEN TRUE 
    ELSE FALSE 
  END AS is_valid_location

FROM `portfolio-eda-project.raw_data.professional_profiles`
WHERE email IS NOT NULL;