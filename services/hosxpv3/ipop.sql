select 
  (
    select
      hospitalcode
    from
      opdconfig
    limit 1
  ) as 'HOSPCODE',
  i.hn as 'HN',
  i.an as 'AN',
  od.icd10 as 'OPER',
  od.diagtype as 'OPTYPE',
  od.doctor as 'PROVIDER',
  '' as 'DATEIN',
  '' as 'TIMEIN',
  '' as 'DATEOUT',
  '' as 'TIMEOUT',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
from
  ovstdiag as od
inner join ipt as i on
  i.vn = od.vn
where
  i.dchdate between '#{start_date}' AND '#{end_date}'
  and left(
        od.icd10,
        1
  ) in (
        '1', '2', '3', '4', '5', '6', '7', '8', '9'
  );
