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
  opi.icode AS 'DID',
  CAST(SUM(opi.qty) as char) AS 'AMOUNT',
  CAST(SUM(opi.unitprice) as char) AS 'DRUGPRICE',
  CAST(SUM(opi.cost) as char) AS 'DRUGCOST',
  (
    SELECT
      d.units
    FROM
      drugitems AS d
    WHERE
      d.icode = opi.icode
    LIMIT 1
  ) AS 'UNIT',
  '' AS 'UNIT_PACK',
  opi.drugusage AS 'SIGCODE',
  opi.doctor AS PROVIDER,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') AS 'D_UPDATE'
FROM
  opitemrece AS opi
INNER JOIN ipt AS ip ON ip.an = opi.an
  AND ip.dchdate BETWEEN '#{start_date}' AND '#{end_date}'
GROUP BY opi.hn, opi.an, opi.icode;