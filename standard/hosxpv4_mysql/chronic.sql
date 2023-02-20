SELECT c.hn as 'HN',
c.dx_date as 'DATE_DIAG',
cl.icd10 as 'CHRONIC',
c.dx_hospcode as 'HOSP_DX',
'' as 'HOSP_RX',
c.dchdate as 'DATE_DISCH',
DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM clinicmember as c 
INNER JOIN clinic as cl ON cl.clinic=c.clinic
INNER JOIN patient as p ON p.hn=c.hn 
WHERE cl.icd10 IN ('E119', 'I10', 'N18')
AND p.type_area IN ('1', '3')
GROUP BY c.hn, c.clinic;
