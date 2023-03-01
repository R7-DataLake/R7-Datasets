SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS 'HOSPCODE',
  o.hn as 'HN',
  o.vn as 'SEQ',
  DATE_FORMAT(o.vstdate, '%Y%m%d') as 'DATEOP',
  od.icd10 as 'OPER',
  od.doctor as 'PROVIDER',
  0 as 'SERVPRICE',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  ovstdiag as od
INNER JOIN ovst as o ON
  o.vn = od.vn
WHERE
  o.vstdate BETWEEN '#{start_date}' AND '#{end_date}'
  AND LEFT(
    od.icd10,
    1
  ) IN (
    '1', '2', '3', '4', '5', '6', '7', '8', '9'
  );
