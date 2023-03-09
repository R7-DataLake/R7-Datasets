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
  do.icd9 as 'OPER',
  do.doctor as 'PROVIDER',
  do.price as 'SERVPRICE',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  doctor_operation as do
INNER JOIN ovst as o ON
  o.vn = do.vn
WHERE
  o.vstdate BETWEEN '#{start_date}' AND '#{end_date}'
  AND LENGTH(do.icd9) > 0
GROUP BY o.hn,o.vn,do.icd9;
