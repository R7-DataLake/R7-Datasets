SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS HOSPCODE,
  od.hn AS HN,
  od.vn AS SEQ,
  DATE_FORMAT(od.vstdate, '%Y%m%d') as DATEOP,
  od.icd10 AS OPER,
  od.doctor AS PROVIDER,
  0 AS SERVPRICE,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as D_UPDATE
FROM
  ovstdiag AS od
INNER JOIN ovst AS o ON
  o.vn = od.vn
WHERE
  LEFT(
    od.icd10,
    1
  ) IN (
    '1', '2', '3', '4', '5', '6', '7', '8', '9'
  )
  AND o.vstdate BETWEEN $1 AND $2;
