SELECT 
  lo.hospcode as 'HOSPCODE',
  lo.hn as 'HN',
  lo.seq as 'SEQ',
  lo.an as 'AN',
  lo.labtest as 'LABTEST',
  lo.labresult as 'LABRESULT',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  r7platform_lab as lo
INNER JOIN r7platform_opd as o ON
  o.seq = lo.seq
  AND o.date_serv BETWEEN '#{start_date}' AND '#{end_date}'
  AND LENGTH(TRIM(lo.labresult)) > 0
GROUP BY lo.hn, lo.seq, lo.labtest;
