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
  p.pname as 'TITLE',
  p.fname as 'FNAME',
  p.lname as 'LNAME',
  p.sex as 'SEX', 
  DATE_FORMAT(p.birthday, "%Y%m%d") as 'BIRTH', 
  p.marrystatus as 'MARRIAGE',
  p.nationality as 'NATION',
  p.chwpart as 'CHANGWAT',
  p.amppart as 'AMPHUR',
  p.tmbpart as 'TAMBOL', 
  p.occupation as 'OCCUPATION',
   p.type_area as 'TYPEAREA',
   DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  patient AS p
WHERE
  EXISTS (
    SELECT
      hn
    FROM
      ovst AS o
    WHERE
      o.hn = p.hn
      AND LENGTH(p.birthday) > 0 AND length(p.type_area) > 0 AND LENGTH(p.cid) = 13 AND LENGTH(p.fname) > 0
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
      ipt AS i
    WHERE
      i.hn = p.hn
      AND length(p.type_area) > 0 AND LENGTH(p.cid) = 13 AND LENGTH(p.fname) > 0
      AND i.dchdate BETWEEN '#{start_date}' AND '#{end_date}'
  )
  AND LENGTH(p.birthday) > 0 AND LENGTH(p.type_area) > 0 AND LENGTH(p.cid) = 13 AND LENGTH(p.fname) > 0
  GROUP BY p.hn, p.cid;
