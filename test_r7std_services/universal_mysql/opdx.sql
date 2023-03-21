SELECT
  od.hospcode as 'HOSPCODE',
  od.hn as 'HN',
  od.seq as 'SEQ',
  DATE_FORMAT(od.date_serv, '%Y%m%d') as 'DATEDX',
  od.diag as 'DIAG',
  od.dxtype as 'DXTYPE',
  od.provider as 'PROVIDER',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  r7platform_opdx as od
WHERE
  EXISTS (
    SELECT
      o.seq
    FROM
      r7platform_opd as o
    WHERE
      o.seq = od.seq
  )
  AND od.date_serv BETWEEN '#{start_date}' AND '#{end_date}'
GROUP BY od.hn, od.seq, od.diag;
