SELECT
  op.hospcode as 'HOSPCODE',
  op.hn as 'HN',
  op.seq as 'SEQ',
  DATE_FORMAT(op.dateop, '%Y%m%d') as 'DATEOP',
  op.oper as 'OPER',
  op.provider as 'PROVIDER',
  op.servprice as 'SERVPRICE',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  r7platform_opop as op
INNER JOIN r7platform_opd as od on od.seq=op.seq
WHERE
  od.date_serv BETWEEN '#{start_date}' AND '#{end_date}'
GROUP BY op.hn, op.seq, op.oper;
