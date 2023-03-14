SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) as 'HOSPCODE',
  p.hn as 'HN',
  p.cid as 'CID',
  '1' as 'IDTYPE',
  TRIM(p.pname) as 'TITLE',
  TRIM(p.fname) as 'FNAME',
  TRIM(p.lname) as 'LNAME',
  p.sex as 'SEX', 
  DATE_FORMAT(p.birthday, "%Y%m%d") as 'BIRTH', 
  p.marrystatus as 'MARRIAGE',
  p.occupation as 'OCCUPATION',
  p.nationality as 'NATION',
  p.chwpart as 'CHANGWAT',
  p.amppart as 'AMPHUR',
  p.tmbpart as 'TAMBOL', 
  p.moopart as 'MOO',
  p.type_area as 'TYPEAREA',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  patient as p
WHERE
  EXISTS (
    SELECT
      hn
    FROM
      ovst as o
    WHERE
      o.hn = p.hn
      AND length(p.birthday) > 0 AND length(TRIM(p.type_area)) > 0 AND LENGTH(TRIM(p.cid)) = 13 AND LENGTH(TRIM(p.fname)) > 0
      AND o.vstdate BETWEEN '#{start_date}' AND '#{end_date}'
      AND 
      EXISTS (
        SELECT
          hn
        FROM
          ovstdiag od
        WHERE
          od.vn = o.vn
      )
  )
  OR EXISTS (
    SELECT
      i.hn
    FROM
      ipt as i
    WHERE
      i.hn = p.hn
      AND length(p.birthday) > 0 AND length(TRIM(p.type_area)) > 0 AND LENGTH(TRIM(p.cid)) = 13 AND LENGTH(TRIM(p.fname)) > 0
      AND i.dchdate BETWEEN '#{start_date}' AND '#{end_date}'
  )
  GROUP BY p.hn, p.cid;
