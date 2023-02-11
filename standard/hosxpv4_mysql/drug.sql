SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS HOSPCODE,
  opi.hn AS HN,
  opi.an AS AN,
  opi.vn AS SEQ,
  opi.icode AS DID,
  opi.qty AS AMOUNT,
  opi.unitprice AS DRUGPRICE,
  opi.cost AS DRUGCOST,
  (
    SELECT
      d.units
    FROM
      drugitems d
    WHERE
      d.icode = opi.icode
    LIMIT 1
  ) AS UNIT,
  '' AS UNIT_PACK,
  opi.drugusage AS SIGCODE,
  opi.doctor AS PROVIDER,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as D_UPDATE
FROM
  opitemrece AS opi
INNER JOIN ipt AS ip ON
  ip.an = opi.an
  AND ip.dchdate BETWEEN $1 AND $2
UNION 
SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS HOSPCODE,
  opi.hn AS HN,
  opi.an AS AN,
  opi.vn AS SEQ,
  opi.icode AS DID,
  opi.qty AS AMOUNT,
  opi.unitprice AS DRUGPRICE,
  opi.cost AS DRUGCOST,
  (
    SELECT
      d.units
    FROM
      drugitems d
    WHERE
      d.icode = opi.icode
    LIMIT 1
  ) AS UNIT,
  '' AS UNIT_PACK,
  opi.drugusage AS SIGCODE,
  opi.doctor AS PROVIDER,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as D_UPDATE
FROM
  opitemrece AS opi
INNER JOIN ovst AS o ON
  o.vn = opi.vn
  AND o.vstdate BETWEEN $3 AND $4
  AND EXISTS (
    SELECT
      vn
    FROM
      ovstdiag od
    WHERE
      od.vn = o.vn
      AND LEFT(
        od.icd10,
        1
      ) NOT IN (
        '1', '2', '3', '4', '5', '6', '7', '8', '9'
      )
  );
