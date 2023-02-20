SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) as 'HOSPCODE',
  i.hn as 'HN',
  idx.an as 'AN',
  idx.icd10 as 'DIAG',
  idx.diagtype as 'DXTYPE',
  idx.doctor as PROVIDER,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  iptdiag as idx
INNER JOIN ipt as i ON
  i.an = idx.an
WHERE
  i.dchdate BETWEEN '#{start_date}' AND '#{end_date}';
