CREATE OR REPLACE VIEW `portfolio-eda-project.raw_data.mart_crm_demographics` AS
SELECT 
  customer_id,
  gender_clean,
  title_clean AS honorific_title,
  
  -- Feature Engineering 1: VIP Marketing Segmentation
  CASE 
    WHEN title_clean IN ('dr', 'dr.', 'md', 'phd', 'prof', 'professor') THEN '1 - Academic & Medical'
    WHEN title_clean IN ('rev', 'rev.', 'honorable', 'hon', 'sir', 'madam') THEN '2 - Gov & Civic'
    WHEN title_clean IN ('mr', 'mr.', 'mrs', 'mrs.', 'ms', 'ms.', 'miss') THEN '3 - Standard Consumer'
    ELSE '4 - Uncategorized'
  END AS customer_segment,

  -- Feature Engineering 2: Data Quality Anomaly Detection
  CASE 
    WHEN gender_clean = 'MALE' AND title_clean IN ('mrs', 'mrs.', 'ms', 'ms.', 'miss', 'madam') THEN 'Flagged: Gender Mismatch'
    WHEN gender_clean = 'FEMALE' AND title_clean IN ('mr', 'mr.', 'sir') THEN 'Flagged: Gender Mismatch'
    ELSE 'Clean Data'
  END AS data_quality_status,
  
  city_clean,
  country_name,
  country_code_clean,
  lat,
  lon
FROM `portfolio-eda-project.raw_data.stg_customer_demographics`
WHERE is_valid_location = TRUE;