SELECT 
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS HOSPCODE,
  i.hn AS HN,
  i.an AS AN,
  do.icd9 AS OPER,
  od.diagtype AS OPTYPE,
  do.doctor AS PROVIDER,
  DATE_FORMAT(do.begin_date_time, '%Y%m%d') AS DATEIN,
  DATE_FORMAT(do.begin_date_time, '%H%i%s') AS TIMEIN,
  DATE_FORMAT(do.end_date_time, '%Y%m%d') AS DATEOUT,
  DATE_FORMAT(do.end_date_time, '%H%i%s') AS TIMEOUT,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM
  doctor_operation AS do
INNER JOIN ipt AS i ON
  i.vn = do.vn
INNER JOIN ovstdiag AS od ON
  od.ovst_diag_id = do.ovst_diag_id
WHERE
  i.dchdate BETWEEN $1 AND $2;
