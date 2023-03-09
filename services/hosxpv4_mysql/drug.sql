SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS 'HOSPCODE',
  opi.hn AS 'HN',
  opi.an AS 'AN',
  opi.vn AS 'SEQ',
  opi.icode AS 'DID',
  opi.qty AS 'AMOUNT',
  opi.unitprice AS 'DRUGPRICE',
  opi.cost AS 'DRUGCOST',
  (
    SELECT
      d.units
    FROM
      drugitems d
    WHERE
      d.icode = opi.icode
    LIMIT 1
  ) AS 'UNIT',
  '' AS 'UNIT_PACK',
  opi.drugusage AS 'SIGCODE',
  opi.doctor AS PROVIDER,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  opitemrece AS opi
INNER JOIN ipt AS ip ON
  ip.an = opi.an
  AND ip.dchdate BETWEEN '#{start_date}' AND '#{end_date}'
GROUP BY opi.hn, opi.vn, opi.icode
UNION 
SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) as 'HOSPCODE',
  opi.hn as 'HN',
  opi.an as 'AN',
  opi.vn as 'SEQ',
  opi.icode as 'DID',
  opi.qty as 'AMOUNT',
  opi.unitprice as 'DRUGPRICE',
  opi.cost as 'DRUGCOST',
  (
    SELECT
      d.units
    FROM
      drugitems d
    WHERE
      d.icode = opi.icode
    LIMIT 1
  ) as 'UNIT',
  '' as 'UNIT_PACK',
  opi.drugusage as 'SIGCODE',
  opi.doctor as 'PROVIDER',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  opitemrece as opi
INNER JOIN ovst as o ON
  o.vn = opi.vn
  AND o.vstdate BETWEEN '#{start_date}' AND '#{end_date}'
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
  )
  GROUP BY opi.hn, opi.vn, opi.icode;
