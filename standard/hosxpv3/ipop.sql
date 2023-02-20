SELECT 
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) as 'HOSPCODE',
  i.hn as 'HN',
  i.an as 'AN',
  do.icd9 as 'OPER',
  od.diagtype as 'OPTYPE',
  do.doctor as PROVIDER,
  DATE_FORMAT(do.begin_date_time, '%Y%m%d') as 'DATEIN',
  DATE_FORMAT(do.begin_date_time, '%H%i%s') as 'TIMEIN',
  DATE_FORMAT(do.end_date_time, '%Y%m%d') as 'DATEOUT',
  DATE_FORMAT(do.end_date_time, '%H%i%s') as 'TIMEOUT',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  doctor_operation as do
INNER JOIN ipt as i ON
  i.vn = do.vn
INNER JOIN ovstdiag as od ON
  od.ovst_diag_id = do.ovst_diag_id
WHERE
  i.dchdate BETWEEN '#{start_date}' AND '#{end_date}';
