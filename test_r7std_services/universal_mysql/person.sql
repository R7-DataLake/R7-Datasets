SELECT
  p.hospcode as 'HOSPCODE',
  p.hn as 'HN',
  p.cid as 'CID',
  TRIM(p.title) as 'TITLE',
  TRIM(p.fname) as 'FNAME',
  TRIM(p.lname) as 'LNAME',
  p.sex as 'SEX', 
  DATE_FORMAT(p.birth, "%Y%m%d") as 'BIRTH', 
  p.marriage as 'MARRIAGE',
  p.nation as 'NATION',
  p.changwat as 'CHANGWAT',
  p.amphur as 'AMPHUR',
  p.tambol as 'TAMBOL', 
  p.occupation as 'OCCUPATION',
  p.typearea as 'TYPEAREA',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM r7platform_person as p
WHERE
  EXISTS (
    SELECT
      hn
    FROM
      r7platform_opd as o
    WHERE
      o.hn = p.hn
      AND o.date_serv BETWEEN '#{start_date}' AND '#{end_date}'
      AND 
      EXISTS (
        SELECT
          hn
        FROM
          r7platform_opdx as od
        WHERE
          od.seq = o.seq
      )
  )
  OR EXISTS (
    SELECT
      i.hn
    FROM
      r7platform_ipd as i
    WHERE
      i.hn = p.hn
      AND i.datedsc BETWEEN '#{start_date}' AND '#{end_date}'
  )
  GROUP BY p.hn, p.cid;
