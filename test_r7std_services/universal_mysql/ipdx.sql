SELECT
  idx.hospcode as 'HOSPCODE',
  idx.hn as 'HN',
  idx.an as 'AN',
  idx.diag as 'DIAG',
  idx.dxtype as 'DXTYPE',
  idx.provider as 'PROVIDER',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  r7platform_ipdx as idx
INNER JOIN r7platform_ipd as i ON
  i.an = idx.an
WHERE
  i.datedsc BETWEEN '#{start_date}' AND '#{end_date}'
GROUP BY idx.hn, idx.an, idx.diag;
