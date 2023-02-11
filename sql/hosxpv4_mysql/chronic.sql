SELECT c.hn AS HN,
c.dx_date AS DATE_DIAG,
cl.icd10 AS CHRONIC,
c.dx_hospcode AS HOSP_DX,
'' AS HOSP_RX,
c.dchdate AS DATE_DISCH,
DATE_FORMAT(now(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM clinicmember AS c 
INNER JOIN clinic AS cl ON cl.clinic=c.clinic
INNER JOIN patient AS p ON p.hn=c.hn 
WHERE cl.icd10 IN ('E119', 'I10', 'N18')
AND p.type_area IN ('1', '3')
GROUP BY c.hn, c.clinic;
