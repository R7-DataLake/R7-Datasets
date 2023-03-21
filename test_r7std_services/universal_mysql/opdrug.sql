SELECT
  odr.hospcode as 'HOSPCODE',
  odr.hn as 'HN',
  odr.seq as 'SEQ',
  odr.did as 'DID',
  odr.amount as 'AMOUNT',
  odr.drugprice as 'DRUGPRICE',
  odr.drugcost as 'DRUGCOST',
  odr.unit as 'UNIT',
  odr.unit_pack as 'UNIT_PACK',
  odr.sigcode as 'SIGCODE',
  odr.provider as 'PROVIDER',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  r7platform_opdrug as odr
INNER JOIN r7platform_opd as o ON
  o.seq = odr.seq
WHERE o.date_serv BETWEEN '#{start_date}' AND '#{end_date}'
GROUP BY odr.hn, odr.seq, odr.did;
