SELECT 
  a.hospcode as 'HOSPCODE',
  a.hn as 'HN',
  a.an as 'AN',
  a.seq as 'SEQ',
  DATE_FORMAT(a.appoint_date, '%Y%m%d') as 'APPOINT_DATE',
  DATE_FORMAT(a.appoint_time, '%H%i') as 'APPOINT_TIME',
  a.clinic as 'CLINIC',
  a.remark as 'REMARK',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  r7platform_appoint as a
WHERE
  a.appoint_date BETWEEN '#{start_date}' AND '#{end_date}'
  AND LENGTH(a.appoint_time) > 0
GROUP BY a.hn, a.appoint_date, a.clinic;
