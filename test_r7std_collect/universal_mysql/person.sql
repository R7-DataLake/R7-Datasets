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
  p.occupation as 'OCCUPATION',
  p.nation as 'NATION',
  p.changwat as 'CHANGWAT',
  p.amphur as 'AMPHUR',
  p.tambol as 'TAMBOL', 
  p.moo as 'MOO',
  p.typearea as 'TYPEAREA',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  r7platform_person as p
GROUP BY p.hn, p.cid;
