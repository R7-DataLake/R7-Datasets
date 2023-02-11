SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS HOSPCODE,
  i.hn AS HN,
  idx.an AS AN,
  idx.icd10 AS DIAG,
  idx.diagtype AS DXTYPE,
  idx.doctor AS PROVIDER,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM
  iptdiag AS idx
INNER JOIN ipt AS i ON
  i.an = idx.an
WHERE
  i.dchdate BETWEEN $1 AND $2;
