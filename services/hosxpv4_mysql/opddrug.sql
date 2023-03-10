SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) as 'HOSPCODE',
  opi.hn as 'HN',
  opi.vn as 'SEQ',
  opi.icode as 'DID',
  SUM(opi.qty) as 'AMOUNT',
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
