SELECT 
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) as 'HOSPCODE',
  a.hn as 'HN',
  a.an as 'AN',
  a.vn as 'SEQ',
  DATE_FORMAT(a.nextdate, '%Y%m%d') as 'APPOINT_DATE',
  DATE_FORMAT(a.nexttime, '%H%i') as 'APPOINT_TIME',
  a.clinic as 'CLINIC',
  a.note as 'REMARK',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  oapp as a
WHERE
  a.vstdate BETWEEN '#{start_date}' AND '#{end_date}'
  AND LENGTH(a.nexttime) > 0
GROUP BY a.hn, a.nextdate, a.clinic;
