SELECT 
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS HOSPCODE,
  a.hn AS HN,
  a.an AS AN,
  a.vn AS SEQ,
  DATE_FORMAT(a.nextdate, '%Y%m%d') AS APPOINT_DATE,
  DATE_FORMAT(a.nexttime, '%H%i') AS APPOINT_TIME,
  a.clinic AS CLINIC,
  a.note AS REMARK,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM
  oapp AS a
WHERE
  a.vstdate BETWEEN $1 AND $2;
