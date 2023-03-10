SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) as 'HOSPCODE',
  od.hn as 'HN',
  od.vn as 'SEQ',
  DATE_FORMAT(od.vstdate, '%Y%m%d') as 'DATEDX',
  od.icd10 as 'DIAG',
  od.diagtype as 'DXTYPE',
  od.doctor as 'PROVIDER',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  ovstdiag as od
WHERE
  EXISTS (
    SELECT
      vn
    FROM
      ovst o
    WHERE
      o.vn = od.vn
  )
  AND LEFT(
    od.icd10,
    1
  ) NOT IN (
    '1', '2', '3', '4', '5', '6', '7', '8', '9'
  )
  AND od.vstdate BETWEEN '#{start_date}' AND '#{end_date}'
GROUP BY od.hn, od.vn, od.icd10;;
