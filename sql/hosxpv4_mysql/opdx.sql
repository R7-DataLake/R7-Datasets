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
  DATE_FORMAT(od.vstdate, '%Y%m%d') AS DATEDX,
  od.icd10 AS DIAG,
  od.diagtype AS DXTYPE,
  od.doctor AS PROVIDER,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as D_UPDATE
FROM
  ovstdiag AS od
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
  AND od.vstdate BETWEEN $1 AND $2;
