SELECT
  idr.hospcode AS 'HOSPCODE',
  idr.hn AS 'HN',
  idr.an AS 'AN',
  idr.did AS 'DID',
  idr.amount AS 'AMOUNT',
  idr.drugprice AS 'DRUGPRICE',
  idr.drugcost AS 'DRUGCOST',
  idr.unit AS 'UNIT',
  idr.unit_pack AS 'UNIT_PACK',
  idr.sigcode AS 'SIGCODE',
  idr.provider AS 'PROVIDER',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') AS 'D_UPDATE'
FROM
  r7platform_ipdrug AS idr
INNER JOIN r7platform_ipd AS ip ON ip.an = idr.an
  AND ip.datedsc BETWEEN '#{start_date}' AND '#{end_date}'
GROUP BY idr.hn, idr.an, idr.did;