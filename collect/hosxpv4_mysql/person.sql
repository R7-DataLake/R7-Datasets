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
  p.occupation as 'OCCUPATION',
  p.marrystatus as 'MARRIAGE',
  p.nationality as 'NATION',
  p.chwpart as 'CHANGWAT',
  p.amppart as 'AMPHUR',
  p.tmbpart as 'TAMBOL', 
  p.moopart as 'MOO',
  p.type_area as 'TYPEAREA',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  patient AS p
  GROUP BY p.hn, p.cid;
