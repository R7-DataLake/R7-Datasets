SELECT
  i.hospcode as 'HOSPCODE',
  i.hn as 'HN',
  i.an as 'AN',
  DATE_FORMAT(i.dateadm, '%Y%m%d') as 'DATEADM',
  DATE_FORMAT(i.timeadm, '%H%i') as 'TIMEADM',
  DATE_FORMAT(i.datedsc, '%Y%m%d') as 'DATEDSC',
  DATE_FORMAT(i.timedsc, '%H%i') as 'TIMEDSC',
  i.discht as 'DISCHT',
  i.dischs as 'DISCHS',
  i.dept as 'DEPT',
  i.warddsc as 'WARDDSC',
  i.adm_w as 'ADM_W',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM r7platform_ipd as i 
WHERE i.datedsc BETWEEN '#{start_date}' AND '#{end_date}'
GROUP BY i.hn, i.an;
