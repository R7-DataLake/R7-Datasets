SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS HOSPCODE,
  o.hn AS HN,
  o.vn AS SEQ,
  DATE_FORMAT(o.vstdate, '%Y%m%d') as DATEOP,
  do.icd9 AS OPER,
  do.doctor AS PROVIDER,
  do.price AS SERVPRICE,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as D_UPDATE
FROM
  doctor_operation AS do
INNER JOIN ovst AS o ON
  o.vn = do.vn
WHERE
  o.vstdate BETWEEN $1 AND $2;
