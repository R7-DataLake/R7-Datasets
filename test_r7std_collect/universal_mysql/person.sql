SELECT
  p.hospcode as 'HOSPCODE',
  p.hn as 'HN',
  p.cid as 'CID',
  TRIM(p.title) as 'TITLE',
  TRIM(p.fname) as 'FNAME',
  TRIM(p.lname) as 'LNAME',
  CAST(p.sex as char) as 'SEX', 
  DATE_FORMAT(p.birth, "%Y%m%d") as 'BIRTH', 
  CAST(p.marriage as char) as 'MARRIAGE',
  CAST(p.nation as char) as 'NATION',
  CAST(p.changwat as char) as 'CHANGWAT',
  CAST(p.amphur as char) as 'AMPHUR',
  CAST(p.tambol as char) as 'TAMBOL', 
  CAST(p.moo as char) as 'MOO',
  CAST(p.occupation as char) as 'OCCUPATION',
  CAST(p.typearea as char) as 'TYPEAREA',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  r7platform_person as p
GROUP BY p.hn, p.cid;
