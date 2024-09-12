-- Example script to test the Remote Function
-- Remark:
-- Change the <PROJECT_ID> values to your used project id.

CREATE TEMP TABLE temp_table_a AS
SELECT 1 AS Id, 'Hans-Peter Müller' AS Name, 'Desc. A1' AS Description
UNION ALL
SELECT 2 AS Id, 'Wladimir Jewtuschenkow' AS Name, 'Desc. A2' AS Description
UNION ALL
SELECT 3 AS Id, 'Christian Meier' AS Name, 'Desc. A3' AS Description
UNION ALL
SELECT 4 AS Id, 'Bill Gates' AS Name, 'Desc. A4' AS Description;

CREATE TEMP TABLE temp_table_b AS
SELECT 1 AS Id, 'Hanspeter Müller-Meyer' AS Name, 'Desc. B1' AS Description
UNION ALL
SELECT 2 AS Id, 'Vladimir Yevtushenkov' AS Name, 'Desc. B2' AS Description
UNION ALL
SELECT 3 AS Id, 'Christine Meier' AS Name, 'Desc. B3' AS Description
UNION ALL
SELECT 4 AS Id, 'William Henry Gates' AS Name, 'Desc. B4' AS Description;

SELECT 
  a.Id AS Id,
  a.Name AS NameA,
  b.Name AS NameB,
  `<PROJECT_ID>.<PROJECT_ID>_esc_pers_name_ds`.esc_pers_name_sim(a.Name, b.Name) AS Similarity
FROM temp_table_a a
JOIN temp_table_b b
ON a.Id = b.Id;

