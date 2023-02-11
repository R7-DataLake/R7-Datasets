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
  DATE_FORMAT(i.regdate, '%Y%m%d') AS DATEADM,
  DATE_FORMAT(i.regtime, '%H%i') AS TIMEADM,
  DATE_FORMAT(i.dchdate, '%Y%m%d') AS DATEDSC,
  DATE_FORMAT(i.dchtime, '%H%i') AS TIMEDSC,
  i.dchtype AS DISCHT,
  i.dchstts AS DISCHS,
  i.ward AS DEPT,
  i.ward AS WARDDSC,
  i.bw AS ADM_W,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as D_UPDATE
FROM ipt AS i 
WHERE i.dchdate BETWEEN $1 AND $2;
