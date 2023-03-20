SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) as 'HOSPCODE',
  o.hn as 'HN',
  o.vn as 'SEQ',
  o.main_dep as 'CLINIC',
  DATE_FORMAT(o.vstdate, '%Y%m%d') as 'DATE_SERV',
  DATE_FORMAT(o.vsttime, '%H%i%s') as 'TIME_SERV',
  os.cc as 'CHIEFCOMP',
  os.temperature as 'BTEMP',
  os.bps as 'SBP',
  os.bpd as 'DBP',
  os.pulse as 'PR',
  os.rr as 'RR',
  os.height as 'HEIGHT',
  os.bw as 'WEIGHT',
  o.ovstist as 'TYPEIN',
  o.ovstost as 'TYPEOUT',
  o.pttype as 'INS_TYPE',
  o.pttypeno as 'INS_NUMBER',
  o.hospmain as 'INS_HOSPMAIN',
  o.hospsub as 'INS_HOSPSUB',
  o.diag_text as 'DIAG_TEXT',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  ovst as o
INNER JOIN opdscreen as os on
  os.vn = o.vn
WHERE
  o.vstdate BETWEEN '#{start_date}' AND '#{end_date}'
  AND EXISTS (
    SELECT
      vn
    FROM
      ovstdiag od
    WHERE
      od.vn = o.vn
      AND LEFT(
        od.icd10,
        1
      ) NOT IN (
        '1', '2', '3', '4', '5', '6', '7', '8', '9'
      )
      AND LENGTH(od.icd10) > 0
  )
GROUP BY o.hn, o.vstdate, o.vn;
