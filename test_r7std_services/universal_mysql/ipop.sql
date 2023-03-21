select 
  op.hospcode as 'HOSPCODE',
  op.hn as 'HN',
  op.an as 'AN',
  op.oper as 'OPER',
  op.optype as 'OPTYPE',
  op.provider as 'PROVIDER',
  op.datein as 'DATEIN',
  op.timein as 'TIMEIN',
  op.dateout as 'DATEOUT',
  op.timeout as 'TIMEOUT',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
from
  r7platform_ipop as op
inner join r7platform_ipd as i on
  op.an = i.an
where
  i.datedsc between '#{start_date}' AND '#{end_date}'
GROUP BY iop.hn, op.an, op.oper;
