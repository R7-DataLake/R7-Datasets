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
  DATE_FORMAT(i.regdate, '%Y%m%d') as 'DATEADM',
  DATE_FORMAT(i.regtime, '%H%i') as 'TIMEADM',
  DATE_FORMAT(i.dchdate, '%Y%m%d') as 'DATEDSC',
  DATE_FORMAT(i.dchtime, '%H%i') as 'TIMEDSC',
  i.dchtype as 'DISCHT',
  i.dchstts as 'DISCHS',
  i.ward as 'DEPT',
  i.ward as 'WARDDSC',
  i.bw as 'ADM_W',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM ipt as i 
WHERE i.dchdate BETWEEN '#{start_date}' AND '#{end_date}'
GROUP BY i.hn, i.an;
